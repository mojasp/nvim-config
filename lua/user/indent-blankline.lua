vim.opt.list = true

vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4048", nocombine = true })
-- vim.api.nvim_set_hl(0, "IblScope", { fg = "#c678dd", nocombine = true })

require("ibl").setup({
    indent = {
        -- highlight = "IblIndent",
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
})
