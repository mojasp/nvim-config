vim.opt.conceallevel = 2

require("cmp").setup.buffer({
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                buffer = "[Buffer]",
                -- formatting for other sources
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "omni" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        -- other sources
    },
})

vim.keymap.set("n", '<localleader>bc', "<cmd>Telescope bibtex<cr>")
vim.keymap.set("n", '<localleader>f', "<cmd>call vimtex#fzf#run()<cr>")
vim.keymap.set("n", '<F1>', "<cmd>:VimtexTocToggle<cr>")

-- --format using fmtprogram (supplied by vimtex..) on save
-- vim.cmd([[
-- function! TEX_Format()
--     let w:v = winsaveview()
--     silent normal gqiP
--     call winrestview(w:v)
-- endfunction
-- augroup Tex
--     autocmd!
--     autocmd BufWritePre <buffer> call TEX_Format()
-- augroup END
-- ]])
