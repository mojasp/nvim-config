local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end
treesitter_configs.setup({
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	-- autopairs = { enable = true },
	autotag = { enable = true },
	indent = { enable = true, disable = {} },
	-- ensure_installed = "all",
	sync_install = true,
	ignore_install = { "phpdoc", "latex" }, -- List of parsers to ignore installation
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
		highlight_current_scope = { enable = false },
	},
	playground = {
		enable = true,
	},
})
