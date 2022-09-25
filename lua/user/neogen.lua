require('neogen').setup({ snippet_engine = "luasnip" })
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>g", ":lua require('neogen').generate()<CR>", opts)
