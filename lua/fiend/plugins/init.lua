return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require 'fiend.configs.autopairs'
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require 'fiend.configs.comment'
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      require 'fiend.configs.completion'
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    config = function()
      require 'fiend.configs.conform'
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = function()
      require 'fiend.configs.debug'
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'fiend.configs.gitsigns'
    end,
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    min = 'ibl',
    config = function()
      require 'fiend.configs.ident-line'
    end,
  },

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'fiend.configs.lint'
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      require 'fiend.configs.lsp'
    end,
  },

  {
    'stevearc/oil.nvim',
    config = function()
      require 'fiend.configs.oil'
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require 'fiend.configs.telescope'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'fiend.configs.todo-comments'
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require 'fiend.configs.treesitter'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'fiend.configs.statusline'
    end,
  },

  -- NOTE: Themes
  {
    'tjdevries/colorbuddy.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 800,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 800,
  },

  {
    'mofiqul/dracula.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 800,
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'edeneast/nightfox.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 800,
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 800,
  },
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
}
