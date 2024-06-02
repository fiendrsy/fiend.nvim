local set = vim.keymap.set

require('bufferline').setup {
  options = {
    buffer_close_icon = '',
    close_icon = '',
    separator_style = 'thin',
    diagnostics = 'nvim_lsp',
    indicator = {
      icon = '',
      style = 'none',
    },
    tab_size = 18,
    diagnostics_indicator = function(_, _, _, context)
      if context.buffer:current() then
        return ''
      end
      return ''
    end,
  },

  highlights = {
    buffer_selected = { italic = false },
    diagnostic_selected = { italic = false },
    hint_selected = { italic = false },
    pick_selected = { italic = false },
    pick_visible = { italic = false },
    pick = { italic = false },
  },
}
-- The next tab
set('n', '<Tab>', '<cmd>bn<cr>')
-- The prev tab
set('n', '<S-Tab>', '<cmd>bp<cr>')
-- Close active tab
set('n', '<S-w>', '<cmd>bp<bar>bd #<cr>')
