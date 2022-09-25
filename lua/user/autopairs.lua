local npairs = require('nvim-autopairs')
npairs.setup()
local Rule = require('nvim-autopairs.rule')
--local cond = require('nvim-autopairs.conds')

npairs.add_rule(Rule("$","$",{"tex", "markdown"}))
