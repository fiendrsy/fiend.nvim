return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>ww',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
    },
  },
  config = function()
    require 'custom.configs.conform'
  end 
}
