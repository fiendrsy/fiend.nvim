local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'

local M = {}
local api = vim.api

M.open_picker = function(opts)
  opts = opts or {}

  opts.previewer = false
  opts.ignore_current_buffer = true
  opts.show_all_buffers = true
  opts.sort_lastused = true

  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local multi_selections = current_picker:get_multi_selection()

      if next(multi_selections) == nil then
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.value, { force = true })
      else
        actions.close(prompt_bufnr)
        for _, selection in ipairs(multi_selections) do
          vim.api.nvim_buf_delete(selection.value, { force = true })
        end
      end
    end

    local open_buf = function()
      local selection = action_state.get_selected_entry()

      actions.close(prompt_bufnr)

      api.nvim_set_current_buf(selection.value)
    end

    map('n', 'x', delete_buf)
    map('n', 'o', open_buf)
    map('n', '<CR>', open_buf)

    return true
  end

  opts.entry_maker = function(entry)
    local bufname = api.nvim_buf_get_name(entry.bufnr)

    bufname = bufname:gsub('%%a', '')

    local filename = vim.fn.fnamemodify(bufname, ':t')

    return {
      valid = true,
      value = entry.bufnr,
      ordinal = filename,
      display = filename,
    }
  end

  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown(opts))
end

return M
