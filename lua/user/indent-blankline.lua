vim.opt.list = true

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    filetype_exclude = { 'dashboard', 'floaterm', 'alpha', 'help', 'packer', 'NvimTree'}
}
