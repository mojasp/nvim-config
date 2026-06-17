#!/usr/bin/env python3
from __future__ import annotations

import argparse
import datetime as dt
import json
import os
import subprocess
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass
from pathlib import Path
from typing import Any


PLUGIN_REPOS = [
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "nvimtools/none-ls.nvim",
    "SmiteshP/nvim-navic",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-omni",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind-nvim",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "honza/vim-snippets",

    "nvim-treesitter/nvim-treesitter",
    "danymat/neogen",
    "hedyhli/outline.nvim",

    "NLKNguyen/papercolor-theme",
    "rebelot/kanagawa.nvim",
    "iruzo/matrix-nvim",
    "catppuccin/nvim",

    "glench/vim-jinja2-syntax",
    "junegunn/fzf",

    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "benfowler/telescope-luasnip.nvim",
    "nvim-telescope/telescope-bibtex.nvim",

    "tpope/vim-dispatch",
    "vim-scripts/a.vim",
    "jalvesaq/Nvim-R",
    "vimwiki/vimwiki",
    "tools-life/taskwiki",
    "lervag/vimtex",

    "stevearc/oil.nvim",
    "lewis6991/gitsigns.nvim",
    "tpope/vim-fugitive",
    "rbong/vim-flog",
    "sindrets/diffview.nvim",
    "nvim-lualine/lualine.nvim",
    "aserowy/tmux.nvim",
    "ahmedkhalf/project.nvim",
    "windwp/nvim-autopairs",
    "junegunn/vim-easy-align",
    "kylechui/nvim-surround",

    "kyazdani42/nvim-web-devicons",
    "lukas-reineke/indent-blankline.nvim",
    "NvChad/nvim-colorizer.lua",
    "petertriho/nvim-scrollbar",
]


@dataclass(frozen=True)
class Pin:
    repo: str
    commit: str
    source: str
    date: str
    tag: str | None = None
    commit_only: bool = False


def parse_github_datetime(value: str) -> dt.datetime:
    return dt.datetime.fromisoformat(value.replace("Z", "+00:00"))


def lua_quote(value: str) -> str:
    return json.dumps(value, ensure_ascii=False)


def token_from_gh_cli() -> str | None:
    try:
        result = subprocess.run(
            ["gh", "auth", "token"],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
        )
        token = result.stdout.strip()
        return token or None
    except Exception:
        return None


class GitHub:
    def __init__(self, token: str | None) -> None:
        self.token = token

    def get(self, path: str) -> Any:
        url = f"https://api.github.com{path}"
        headers = {
            "Accept": "application/vnd.github+json",
            "User-Agent": "nvim-plugin-pin-resolver",
            "X-GitHub-Api-Version": "2022-11-28",
        }

        if self.token:
            headers["Authorization"] = f"Bearer {self.token}"

        request = urllib.request.Request(url, headers=headers)

        for attempt in range(4):
            try:
                with urllib.request.urlopen(request, timeout=30) as response:
                    return json.loads(response.read().decode("utf-8"))
            except urllib.error.HTTPError as exc:
                body = exc.read().decode("utf-8", errors="replace")
                if exc.code in (403, 429) and attempt < 3:
                    time.sleep(2 ** attempt)
                    continue
                raise RuntimeError(f"GitHub API error {exc.code} for {url}:\n{body}") from exc
            except urllib.error.URLError as exc:
                if attempt < 3:
                    time.sleep(2 ** attempt)
                    continue
                raise RuntimeError(f"GitHub API connection error for {url}: {exc}") from exc

        raise RuntimeError(f"failed to fetch {url}")

    def get_pages(self, path: str, pages: int = 5) -> list[Any]:
        out: list[Any] = []

        separator = "&" if "?" in path else "?"
        for page in range(1, pages + 1):
            data = self.get(f"{path}{separator}page={page}")
            if not data:
                break
            out.extend(data)

        return out

    def repo_default_branch(self, repo: str) -> str:
        info = self.get(f"/repos/{repo}")
        return info["default_branch"]

    def commit_date(self, repo: str, sha: str) -> dt.datetime:
        commit = self.get(f"/repos/{repo}/commits/{sha}")
        return parse_github_datetime(commit["commit"]["committer"]["date"])

    def resolve_tag_to_commit(self, repo: str, tag: str) -> str:
        encoded_tag = urllib.parse.quote(tag, safe="")
        ref = self.get(f"/repos/{repo}/git/ref/tags/{encoded_tag}")
        obj = ref["object"]

        if obj["type"] == "commit":
            return obj["sha"]

        if obj["type"] == "tag":
            tag_obj = self.get(f"/repos/{repo}/git/tags/{obj['sha']}")
            target = tag_obj["object"]
            if target["type"] != "commit":
                raise RuntimeError(f"{repo}@{tag} resolves to {target['type']}, not commit")
            return target["sha"]

        raise RuntimeError(f"{repo}@{tag} resolves to unsupported object type {obj['type']}")

    def find_release_pin(self, repo: str, cutoff: dt.datetime) -> Pin | None:
        releases = self.get_pages(f"/repos/{repo}/releases?per_page=100", pages=3)

        for release in releases:
            if release.get("draft") or release.get("prerelease"):
                continue

            published_at = parse_github_datetime(release["published_at"])
            if published_at > cutoff:
                continue

            tag = release["tag_name"]
            commit = self.resolve_tag_to_commit(repo, tag)

            return Pin(
                repo=repo,
                tag=tag,
                commit=commit,
                source="release",
                date=published_at.date().isoformat(),
            )

        return None

    def find_tag_pin(self, repo: str, cutoff: dt.datetime) -> Pin | None:
        tags = self.get_pages(f"/repos/{repo}/tags?per_page=100", pages=5)
        candidates: list[Pin] = []

        for tag in tags:
            name = tag["name"]
            commit = tag["commit"]["sha"]
            committed_at = self.commit_date(repo, commit)

            if committed_at <= cutoff:
                candidates.append(
                    Pin(
                        repo=repo,
                        tag=name,
                        commit=commit,
                        source="tag",
                        date=committed_at.date().isoformat(),
                    )
                )

        candidates.sort(key=lambda p: p.date, reverse=True)
        return candidates[0] if candidates else None

    def find_commit_pin(self, repo: str, cutoff: dt.datetime) -> Pin | None:
        branch = self.repo_default_branch(repo)
        commits = self.get_pages(
            f"/repos/{repo}/commits?sha={urllib.parse.quote(branch)}&per_page=100",
            pages=3,
        )

        for item in commits:
            sha = item["sha"]
            committed_at = parse_github_datetime(item["commit"]["committer"]["date"])

            if committed_at <= cutoff:
                return Pin(
                    repo=repo,
                    commit=sha,
                    source=f"default-branch:{branch}",
                    date=committed_at.date().isoformat(),
                    tag=None,
                    commit_only=True,
                )

        return None


def render_lua(pins: list[Pin]) -> str:
    lines = [
        "-- Generated by tools/update-plugin-pins.py",
        "-- Do not edit by hand.",
        "--",
        "-- Selection rule:",
        "--   1. latest non-draft, non-prerelease GitHub release older than the cutoff",
        "--   2. otherwise latest Git tag whose resolved commit is older than the cutoff",
        "--   3. otherwise latest default-branch commit older than the cutoff",
        "--",
        "-- commit_only = true means the repository has no usable release/tag pin.",
        "",
        "return {",
    ]

    for p in sorted(pins, key=lambda item: item.repo.lower()):
        lines.append(f"    [{lua_quote(p.repo)}] = {{")
        if p.tag is not None:
            lines.append(f"        tag = {lua_quote(p.tag)},")
        lines.append(f"        commit = {lua_quote(p.commit)},")
        lines.append(f"        source = {lua_quote(p.source)},")
        lines.append(f"        date = {lua_quote(p.date)},")
        if p.commit_only:
            lines.append("        commit_only = true,")
        lines.append("    },")

    lines.append("}")
    lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--output",
        default="lua/plugin_pins.lua",
        help="Path to generated Lua pin table",
    )
    parser.add_argument(
        "--days",
        type=int,
        default=14,
        help="Minimum release/tag/commit age in days",
    )
    parser.add_argument(
        "--strict-tags",
        action="store_true",
        help="Fail if a plugin has no usable release or tag; do not use commit-only fallback",
    )
    args = parser.parse_args()

    token = os.environ.get("GITHUB_TOKEN") or token_from_gh_cli()
    if not token:
        print(
            "Warning: no GITHUB_TOKEN and no gh auth token found; "
            "you will probably hit GitHub's unauthenticated rate limit.",
            file=sys.stderr,
        )

    github = GitHub(token=token)

    now = dt.datetime.now(dt.timezone.utc)
    cutoff = now - dt.timedelta(days=args.days)

    pins: list[Pin] = []
    failures: list[str] = []

    for repo in PLUGIN_REPOS:
        print(f"Resolving {repo}...", file=sys.stderr)

        try:
            pin = github.find_release_pin(repo, cutoff)
            if pin is None:
                pin = github.find_tag_pin(repo, cutoff)
            if pin is None and not args.strict_tags:
                pin = github.find_commit_pin(repo, cutoff)

            if pin is None:
                failures.append(f"{repo}: no release/tag/commit older than {args.days} days")
            else:
                pins.append(pin)
        except Exception as exc:
            failures.append(f"{repo}: {exc}")

    if failures:
        print("\nFailed to pin these plugins:\n", file=sys.stderr)
        for failure in failures:
            print(f"  - {failure}", file=sys.stderr)
        print("\nNo file written.", file=sys.stderr)
        return 1

    output = Path(args.output)
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(render_lua(pins), encoding="utf-8")

    release_count = sum(1 for p in pins if p.source == "release")
    tag_count = sum(1 for p in pins if p.source == "tag")
    commit_only_count = sum(1 for p in pins if p.commit_only)

    print(f"Wrote {output}", file=sys.stderr)
    print(
        f"Pins: {release_count} releases, {tag_count} tags, "
        f"{commit_only_count} commit-only fallbacks",
        file=sys.stderr,
    )

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
