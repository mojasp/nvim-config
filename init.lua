vim.loader.enable()

-- disable shadafile while sourcing config
vim.opt.shadafile = "NONE"

local home = os.getenv("HOME")
 -- annoying to do manually... should maybe migrate to lazy.nvim
package.path = package.path .. ';' .. home .. '/.luarocks/share/lua/5.4/?.lua'
package.path = package.path .. ';' .. home .. '/.luarocks/share/lua/5.4/?/init.lua'
-- package.cpath = package.cpath .. ';' .. home .. '/.luarocks/lib/luarocks/rocks-5.4/?/?.so'

require('plugins')
require('global')
require('keymaps')
require('user')

-- reenable
vim.opt.shadafile = ""

-- latex plugin once needed
