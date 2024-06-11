require('bufferline').setup {
  options = {
    buffer_close_icon = '',
    close_icon = '',
    modified_icon = '?',
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
