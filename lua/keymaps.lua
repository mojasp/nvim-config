local opts = { noremap = true, silent = true }
local allmodes = { "n", "x", "i" }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- c-q to delete current buffer
vim.keymap.set(allmodes, "<C-Q>", function() vim.cmd("bd!") end, opts)

keymap("n", "<F3>", ":set hlsearch!<CR>", opts)

--use [,{,],} from english layout -- note: changing layout instead is better..
vim.keymap.set(allmodes, "ö", "[", opts)
vim.keymap.set(allmodes, "Ö", "{", opts)
vim.keymap.set(allmodes, "ä", "]", opts)
vim.keymap.set(allmodes, "Ä", "}", opts)
vim.keymap.set("n", "öö", "[[", opts)
vim.keymap.set("n", "öä", "[]", opts)
vim.keymap.set("n", "äö", "][", opts)
vim.keymap.set("n", "ää", "]]", opts)

--paste into new line
keymap("n", "ü", ":pu<cr>", opts)
keymap("n", "Ü", ":pu!<CR>", opts)

--Accept autocomplete in insert mode
keymap("i", "<C-a>", "<Esc>A;<CR>", opts)

--mappings for building and cleaning
keymap("n", "<leader>m", ":Make!<CR><CR>", opts)
keymap("n", "<leader>c", ":Make! clean<CR><CR>", opts)

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
keymap("n", "<C-ü>", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<C-l>", "<cmd>Telescope luasnip<cr>", opts)
keymap("i", "<C-l>", "<cmd>Telescope luasnip<cr>", opts)
keymap("n", "<leader>s", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>S", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)

--dap
vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
end, opts)
vim.keymap.set("n", "<F6>", function()
    require("dap").step_over()
end, opts)
vim.keymap.set("n", "<F7>", function()
    require("dap").step_into()
end, opts)
vim.keymap.set("n", "<F8>", function()
    require("dap").step_out()
end, opts)
vim.keymap.set("n", "<Leader>b", function()
    require("dap").toggle_breakpoint()
end, opts)
vim.keymap.set("n", "<Leader>B", function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, opts)
vim.keymap.set("n", "<Leader>lp", function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, opts)
vim.keymap.set("n", "<Leader>dr", function()
    require("dap").repl.open()
end, opts)
vim.keymap.set("n", "<Leader>dl", function()
    require("dap").run_last()
end, opts)
vim.keymap.set("x", "<Leader>de", function()
    require("dapui").eval()
end, opts)
vim.keymap.set("n", "<Leader>de", function()
    require("dapui").eval()
end, opts)
vim.keymap.set("n", "<Leader>dt", function()
    require("dap").terminate()
end, opts)
vim.keymap.set("n", "<Leader>df", function()
    require("dapui").float_element()
end, opts)
vim.keymap.set("n", "<Leader>dc", function()
    require("dapui").close()
end, opts)

--nvimtree
keymap("n", "<F2>", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", opts)

--easy-align
keymap("n", "ga", "<Plug>(EasyAlign)", opts)
keymap("x", "ga", "<Plug>(EasyAlign)", opts)

--diffview(git)
keymap("n", "<leader>gv", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>gc", ":DiffviewClose<CR>", opts)
keymap("n", "<leader>gs", ":Git<CR>", opts)
keymap("n", "<leader>gl", ":0Gclog<CR>", opts)

--stage hunks, undo, next hunk
keymap("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
keymap("x", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
keymap("n", "<leader>hn", ":Gitsigns next_hunk<CR><CR>", opts)
keymap("n", "<leader>hp", ":Gitsigns prev_hunk<CR><CR>", opts)
keymap("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
keymap("x", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)

vim.api.nvim_set_keymap("n", "mr", ":Neomake!<CR>", opts)
vim.api.nvim_set_keymap("n", "mc", ":NeomakeSh ./.configure.sh<CR>", opts)

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
