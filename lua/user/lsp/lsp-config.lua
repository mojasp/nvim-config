local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

-- Completion kinds
local servers = {
    "clangd",
    "pyright",
    "lua_ls",
    "eslint",
    "bashls",
    "yamlls",
    "jsonls",
    "cssls",
    "html",
    "r_language_server",
    "marksman",
    "cmake",
}

mason_lspconfig.setup({
    ensure_installed = servers,
})

local lspconfig = require("lspconfig")
local on_attach = require("user.lsp.lsp-handlers").on_attach
local capabilities = require("user.lsp.lsp-handlers").capabilities

--
-- -- special treatment for zig
-- -- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0
-- -- disable format-on-save from `ziglang/zig.vim`
vim.g.zig_fmt_autosave = 0
-- -- enable  format-on-save from nvim-lspconfig + ZLS
vim.cmd([[autocmd BufWritePre *.zig lua vim.lsp.buf.format()]])

lspconfig["zls"].setup({
    -- Server-specific settings. See `:help lspconfig-setup`
    -- omit the following line if `zls` is in your PATH
    cmd = { '/home/moritz/Documents/Programming/zig_ffmpegexample/zls' },

    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://github.com/zigtools/zls/wiki/Configuration
    root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
    settings = {
        zls = {
            enable_inlay_hints = true,
            enable_snippets = true,
            warn_style = true,
            enable_autofix = true,
            build_on_save_args = "check",
            enable_build_on_save = true,
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

--
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

lspconfig.bashls.setup({
    on_attach = on_attach,
    filetypes = { "bash", "sh" },
    capabilities = capabilities,
})

lspconfig.marksman.setup({
    on_attach = on_attach,
    filetypes = { "markdown" },
    capabilities = capabilities,
})

local capabilities_cpp = capabilities
capabilities_cpp.offsetEncoding = { "uts-16" }
lspconfig["clangd"].setup({
    cmd = {
        "clangd",
        "--fallback-style=webkit",
    },
    on_attach = on_attach,
    capabilities = capabilities_cpp,
})
