return {
  {
    'tjdevries/colorbuddy.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        styles = {
          bold = false,
          italic = false,
          transparency = true,
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      no_italic = true,
      no_bold = true,
      no_underline = true,
    },
  },
}
