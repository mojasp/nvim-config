local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

keymap("n", "<F3>", ":set hlsearch!<CR>", opts)

--paste into new line
keymap("n", "ü", ":pu<cr>", opts)
keymap("n", "Ü", ":pu!<CR>", opts)

--Accept autocomplete in insert mode
keymap("i", "<C-a>", "<Esc>A;<CR>", opts)

--mappings for building and cleaning
keymap("n", "<leader>m", ":Make!<cr>", opts)
keymap("n", "<leader>c", ":Make! clean<cr>", opts)

--navigate quickfix list
keymap("n", "<C-n>", "<cmd>:cn<cr>", opts)
keymap("n", "<C-p>", "<cmd>:cp<cr>", opts)
--sidebar with symbols
keymap("n", "<F1>", ":SymbolsOutline<cr>", opts)

--telescope
keymap("n", "<C-b>", "<cmd>lua require('telescope.builtin').oldfiles()<cr>", opts)
keymap("n", "<C-f>", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
keymap("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap("n", ";", "<cmd>lua require('telescope.builtin').buffers({sort_lastused=true, initial_mode=normal})<cr>", opts)
keymap("n", "<C-c>", "<cmd>lua require('telescope.builtin').commands()<cr>", opts)
keymap("n", "<C-l>", "<cmd>Telescope projects<cr>", opts)
keymap("n", "-", "<cmd>Telescope luasnip<cr>", opts)
keymap("i", "<C-->", "<cmd>Telescope luasnip<cr>", opts)
keymap("n", "<leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>S", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)

--nvimtree
keymap("n", "<F2>", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", opts)

--easy-align
keymap("n", "ga", "<Plug>(EasyAlign)", opts)
keymap("x", "ga", "<Plug>(EasyAlign)", opts)

--diffview(git)
keymap("n", "<leader>do", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>dc", ":DiffviewClose<CR>", opts)

--stage hunks, undo, next hunk
keymap("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
keymap("n", "<leader>hn", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>hp", ":Gitsigns prev_hunk<CR>", opts)

-- diagnostics behaviour
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next({float=false})<CR>", opts)
vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = false,
    signs = true,
    underline = false,
    update_in_insert = true,
    severity_sort = false,

    float = {
        focusable = false,
        source = "always",
        header = "",
        prefix = "",
    },
})

vim.api.nvim_set_keymap("n", "mr", ":Neomake!<CR>", opts)
vim.api.nvim_set_keymap("n", "mc", ":NeomakeSh ./.configure.sh<CR>", opts)

vim.keymap.set("n", "<F12>", function()
    local OFF = 0 -- also disable update while typing. Enable popup diagnostic on "next error map"
    local VLINES = 1 -- also enable update while typing
    local VTEXT = 2 -- also enable updates while typing

    local virtual_lines_enabled = vim.diagnostic.config().virtual_lines
    local virtual_text_enabled = vim.diagnostic.config().virtual_text

    local mode
    if virtual_lines_enabled then
        mode = VLINES
    elseif virtual_text_enabled then
        mode = VTEXT
    else
        mode = OFF
    end

    mode = mode + 1
    if mode > 2 then
        mode = 0
    end

    if mode == OFF then
        print(mode)
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
        })
        vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev( {float=true} )<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next( {float=true} )<CR>", opts)
    elseif mode == VLINES then
        print(mode)
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = true,
        })
        vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next({float=false})<CR>", opts)
    else
        print(mode)
        vim.diagnostic.config({
            virtual_text = true,
            virtual_lines = false,
        })
        vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua vim.diagnostic.goto_prev({float=false})<CR>", opts)
        vim.api.nvim_set_keymap("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next({float=false})<CR>", opts)
    end
end)
