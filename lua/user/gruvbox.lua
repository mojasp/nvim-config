-- setup must be called before loading the colorscheme
-- Default options:
-- require("gruvbox").setup({
--     undercurl = true,
--     underline = true,
--     bold = true,
--     italic = true,
--     strikethrough = true,
--     invert_selection = false,
--     invert_signs = false,
--     invert_tabline = false,
--     invert_intend_guides = false,
--     inverse = true, -- invert background for search, diffs, statuslines and errors
--     contrast = "", -- can be "hard", "soft" or empty string
--     overrides = {},
-- })

if vim.g.neovide then
    vim.cmd([[
        colorscheme kanagawa
        set guifont=juliamono:h8
        let g:neovide_transparency=0.85
        let g:neovide_refresh_rate=60
        let g:neovide_refresh_rate_idle=2
        let g:neovide_hide_mouse_when_typing = v:true
    ]])
else
    vim.cmd([[
        colorscheme kanagawa
        set guifont=JetBrains\ Mono:h11
        " hi Normal guibg=NONE ctermbg=NONE
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE

        highlight SignColumn guibg=NONE ctermbg=NONE
        highlight VertSplit guibg=NONE ctermbg=NONE
        highlight StatusLine guibg=NONE ctermbg=NONE
        highlight StatusLineNC guibg=NONE ctermbg=NONE
        highlight LineNr ctermbg=NONE guibg=NONE
        highlight CursorLineNr ctermbg=NONE guibg=NONE
        highlight FoldColumn ctermbg=NONE guibg=NONE
        highlight SignColumn ctermbg=NONE guibg=NONE
        ]])
end
