return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    min = 'ibl',
    config = function()
      require 'custom.configs.ident-line'
    end,
  },
}
