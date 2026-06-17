vim.opt.list = true

require("ibl").setup({
    scope = {
        enabled = true,
    },
    exclude = {
        filetypes = {
            "dashboard",
            "floaterm",
            "alpha",
            "help",
            "packer",
            "lazy",
            "NvimTree",
        },
    },
    whitespace = {
        remove_blankline_trail = true,
    },
})
