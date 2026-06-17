vim.loader.enable()

-- disable shadafile while sourcing config
vim.opt.shadafile = "NONE"

require('global')
require('plugins')
require('keymaps')
require('user')

-- reenable
vim.opt.shadafile = ""

-- only for managed system
vim.g.python3_host_prog = vim.fn.expand("~/.venvs/nvim/bin/python3")
-- latex plugin once needed
