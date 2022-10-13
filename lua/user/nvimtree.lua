require("nvim-tree").setup({
    view = {
        mappings = {
            list = {
                { key = "<CR>", action = "edit_in_place" },
            },
        },
    },
})
local function toggle_replace()
    local view = require("nvim-tree.view")
    if view.is_visible() then
        view.close()
    else
        require("nvim-tree").open_replacing_current_buffer()
    end
end

vim.keymap.set("n", "-", toggle_replace, {noremap=true});
vim.keymap.set("n", "_", toggle_replace, {noremap=true});
