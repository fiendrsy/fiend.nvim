local actions = require 'telescope.actions'

local set = vim.keymap.set

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      n = {
        ['q'] = actions.close,
      },
    },
    file_ignore_patterns = { 'node_modules', '.git', '.idea', '.DS_Store', '.github' },
    path_display = { 'truncate' },
    pickers = {},
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

set('n', '<space>ff', builtin.find_files)
set('n', '<space>gs', builtin.grep_string)
set('n', '<space>fg', builtin.live_grep)
set('n', '<space>gf', builtin.git_files)
set('n', '<space>bf', builtin.current_buffer_fuzzy_find)

set('n', '<leader>g.', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end)

set('n', '<space>fa', function()
  --@diagnostic disable-next-line: param-type-mismatch
  builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy') }
end)

set('n', '<space>sc', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end)

set('n', '<space>scb', function()
  builtin.find_files { cwd = '~/.config/nvim-backup/' }
end)

set('n', '<leader>/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)
