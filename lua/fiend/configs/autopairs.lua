local cmp = require 'cmp'
local npairs = require 'nvim-autopairs'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

npairs.setup {}

npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
npairs.add_rules(require 'nvim-autopairs.rules.endwise-elixir')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
