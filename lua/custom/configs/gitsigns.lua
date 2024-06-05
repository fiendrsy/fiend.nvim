local ok, signs = pcall(require, 'gitsigns')

if not ok then
  return
end

require 'colorbuddy'

local c = require('colorbuddy.color').colors
local Group = require('colorbuddy.group').Group

Group.new('GitSignsAdd', c.green)
Group.new('GitSignsChange', c.yellow)
Group.new('GitSignsDelete', c.red)

signs.setup {
  signs = {
    add = { hI = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr' },
    change = { h1 = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr' },
    delete = { h1 = 'GitSignsDelete', text = '▎', numh1 = 'GitSignsDeleteNr' },
    topdelete = { h1 = 'GitSignsDelete', text = '▎', numhl = 'GitSignsDeleteNr' },
    changedelete = { hi = 'GitSignsDelete', text = '▎', numhl = 'GitSignsChangeNr' },
  },
}
