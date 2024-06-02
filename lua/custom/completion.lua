local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },

  mapping = cmp.mapping.preset.insert {
    -- Select the next item
    ['<Tab>'] = cmp.mapping.select_next_item(),
    -- Select the previous item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- Accept currently selected item
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}
