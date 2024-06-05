return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require 'custom.configs.treesitter'
  end,
}
