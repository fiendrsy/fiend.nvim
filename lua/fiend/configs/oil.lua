require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = false,
  },
  keymaps = require('mappings').oil(),
}

