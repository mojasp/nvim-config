require("tmux").setup({
    -- overwrite default configuration
    -- here, e.g. to enable default bindings
    copy_sync = {
        -- enables copy sync and overwrites all register actions to
        -- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
        -- enable = true,
        -- redirect_to_clipboard = true
    },
    navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,
 
        -- sets resize steps for x axis
        resize_step_x = 3,

        -- sets resize steps for y axis
        resize_step_y = 3,       
    }
})
