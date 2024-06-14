local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'

local M = {}
local api = vim.api
local fn = vim.fn

local function is_buffer_modified(bufnr)
  return api.nvim_buf_get_option(bufnr, 'modified')
end

local function split_path(bufnr)
  local path = api.nvim_buf_get_name(bufnr)

  -- Extract file and dir for example: PATH.../dir/file.lua
  local file = fn.fnamemodify(path, ':t')
  local dir = fn.fnamemodify(path, ':h:t')

  return {
    file_name = file,
    parent_dir = dir,
    full_path = path,
  }
end

local function get_display_name(entry, duplicates)
  local MODIFIED_SYMBOL, SEPARATOR = '??', '/'

  local path_fragments = split_path(entry.bufnr)
  local display_name

  if duplicates[path_fragments.file_name] then
    display_name = path_fragments.parent_dir .. SEPARATOR .. path_fragments.file_name
  else
    display_name = path_fragments.file_name
  end

  if is_buffer_modified(entry.bufnr) then
    display_name = MODIFIED_SYMBOL .. ' ' .. display_name
  end

  return display_name
end

local function find_duplicates(entries)
  local counts = {}

  for _, entry in ipairs(entries) do
    local path_fragments = split_path(entry.bufnr)
    counts[path_fragments.file_name] = (counts[path_fragments.file_name] or 0) + 1
  end

  local duplicates = {}

  for name, count in pairs(counts) do
    if count > 1 then
      duplicates[name] = true
    end
  end

  return duplicates
end

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

        if is_buffer_modified(selection.value) then
          print 'Buffer is not saved! Save it before closing.'

          actions.close(prompt_bufnr)

          api.nvim_set_current_buf(selection.value)

          return
        end

        actions.close(prompt_bufnr)

        api.nvim_buf_delete(selection.value, { force = true })
      else
        actions.close(prompt_bufnr)

        for _, selection in ipairs(multi_selections) do
          if is_buffer_modified(selection.value) then
            print 'One or more buffers are not saved! Save them before closing.'

            return
          end

          api.nvim_buf_delete(selection.value, { force = true })
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
    return {
      valid = true,
      value = entry.bufnr,
      ordinal = split_path(entry.bufnr).full_path,
      display = function()
        local duplicates = find_duplicates(fn.getbufinfo { buflisted = 1 })
        return get_display_name(entry, duplicates)
      end,
    }
  end

  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown(opts))
end

return M
