vim.loader.enable()

-- disable shadafile while sourcing config
vim.opt.shadafile = "NONE"

require('plugins')
require('global')
require('keymaps')
require('user')

-- reenable
vim.opt.shadafile = ""

-- latex plugin once needed
