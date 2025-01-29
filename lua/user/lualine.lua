local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local lsp_signature = require("lsp_signature")
local current_signature_hint = function()
    return lsp_signature.status_line(0).hint
end
--always show winbar
local winbar_placeholder = function()
    return "   "
end

local location = { "location", padding = 0 }
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {
            winbar = {
                "fugitive",
                "NvimTree",
                "alpha",
                "diffview",
            },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = false,
        globalstatus = true,
    },
    sections = {
        lualine_a = { { "branch" } },
        lualine_b = { { "diff", source = diff_source }, { "diagnostics" } },
        lualine_c = { {"navic", color_correction=nil, navic_opts=nil} },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { location },
    },
    winbar = {
        lualine_a = { },
        lualine_b = { },
        lualine_c = { {
            "filename",
            path = 1,
        } },
        lualine_x = { { winbar_placeholder } },
        lualine_y = { { current_signature_hint } },
        lualine_z = { {} },
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { {
            "filename",
            path = 1,
        } },
        lualine_x = { { winbar_placeholder } },
        lualine_y = { {} },
        lualine_z = { {} },
    },
    tabline = {},
    extensions = { "quickfix", "fugitive", "fzf", "man", "nvim-tree" },
})
