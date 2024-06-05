local set = vim.keymap.set

require('oil').setup {
  default_file_explorer = true,
  view_options = {
    show_hidden = false,
  },
  keymaps = {
    ['g?'] = 'actions.show_help',
    ['o'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
  },
}

 -- Open parent directory
set('n', '-', '<cmd>Oil<cr>')

-- Toggle oil
set('n', '<leader>ee', require('oil').toggle_float)
