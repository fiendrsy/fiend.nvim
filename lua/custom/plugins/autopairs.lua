return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    local npairs = require 'nvim-autopairs'

    npairs.setup {}

    npairs.add_rules(require 'nvim-autopairs.rules.endwise-ruby')
    npairs.add_rules(require 'nvim-autopairs.rules.endwise-lua')
    npairs.add_rules(require 'nvim-autopairs.rules.endwise-elixir')

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
