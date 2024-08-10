local M = {}

M.ui = {
  theme = {
    name = 'nightfox',
    style = 'terafox',
  },
  default_theme = {
    name = 'rose-pine',
    style = 'moon',
    transparent = true,
  },
}

M.activate_theme = function()
  local theme = M.ui.theme
  local themes = require 'fiend.theming.themes'

  themes.activate_theme(theme.name, theme.style)
end

M.languages = function()
  local list_languages = require('fiend.helpers').list_languages()

  if list_languages == nil then
    return
  end

  for _, lang in ipairs(list_languages) do
    require('fiend.languages' .. '.' .. lang).setup()
  end
end

M.setup = function()
  local g = vim.g
  local opt = vim.opt
  local autocmd = vim.api.nvim_create_autocmd
  
  -- NOTE: Highlight when yanking (copying) text
  autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('fiend-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- Bind space key
  g.mapleader = ' '

  -- By default we don't have a font
  g.have_nerd_font = false

  -- Make line numbers default
  opt.number = true
  opt.relativenumber = true

  -- Removing '~' that claimed the empty lines
  opt.fillchars:append { eob = ' ' }

  -- Indent
  opt.tabstop = 2
  opt.softtabstop = 2
  opt.shiftwidth = 2
  opt.expandtab = true
  opt.smartindent = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  opt.mouse = 'a'

  -- Don't spawn the swapfile
  opt.swapfile = false

  -- Don't show the mode, since it's already in the status line
  opt.showmode = false

  -- Sync clipboard between OS and Neovim.
  opt.clipboard = 'unnamedplus'

  -- Enable break indent
  opt.breakindent = true

  -- Save undo history
  opt.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  opt.ignorecase = true
  opt.smartcase = true

  -- Keep signcolumn on by default
  opt.signcolumn = 'yes'

  -- Decrease update time
  opt.updatetime = 250

  -- Decrease mapped sequence wait time
  -- Displays which-key popup sooner
  opt.timeoutlen = 300

  -- Configure how new splits should be opened
  opt.splitright = true
  opt.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  opt.list = true
  opt.listchars = { tab = '▎ ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  opt.inccommand = 'split'

  -- Show which line your cursor is on
  opt.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  opt.scrolloff = 10

  -- Set highlight on search, but clear on pressing <Esc> in normal mode
  opt.hlsearch = true
end

return M
