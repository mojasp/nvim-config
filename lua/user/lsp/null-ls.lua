local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.prettier,
        formatting.codespell,
        diagnostics.codespell.with({
            disabled_filetypes={"tex", "md", "vimwiki"}

        }),
        diagnostics.cppcheck.with({
            extra_args = { "--surpresss=cstyleCast" },
        }),
        -- code_actions.gitsigns, --always at top of codeactions... annoying
        code_actions.proselint,
        null_ls.builtins.completion.spell
    },
})
