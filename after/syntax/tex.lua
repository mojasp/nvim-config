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
