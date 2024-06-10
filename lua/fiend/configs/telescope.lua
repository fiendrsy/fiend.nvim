local actions = require 'telescope.actions'

-- Init mappings for telescope
require('fiend.mappings').telescope()

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
