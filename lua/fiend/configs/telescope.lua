local actions = require 'telescope.actions'

require('telescope').setup {
  defaults = {
    initial_mode = 'normal',
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
