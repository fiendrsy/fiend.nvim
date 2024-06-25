local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local previewers = require 'telescope.previewers'

local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_set = require 'telescope.actions.set'
local action_state = require 'telescope.actions.state'

local themes = require 'fiend.theming.themes'
local M = {}

local function get_entries(theme_entries)
  local entries = {}
  for theme_name, theme in pairs(theme_entries) do
    for _, style in pairs(theme.style) do
      table.insert(entries, {
        theme_name,
        style,
        theme.transparent,
      })
    end
  end

  return entries
end

local function reload_theme(name, style)
  themes.activate_theme(name, style)
end

M.open_picker = function()
  local api = vim.api

  local bufnr = api.nvim_get_current_buf()

  -- NOTE: Show current buffer content in previewer
  local previewer = previewers.new_buffer_previewer {
    define_preview = function(self, _)
      -- Add content
      local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
      api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- Add syntax highlighting in previewer
      local ft = (vim.filetype.match { buf = bufnr } or 'diff'):match '%w+'
      require('telescope.previewers.utils').highlighter(self.state.bufnr, ft)
    end,
  }

  -- NOTE: Picker theme function
  local picker = pickers.new({}, {
    prompt_title = 'Themes',
    previewer = previewer,
    finder = finders.new_table {
      results = get_entries(themes.themes),
      entry_maker = function(entry)
        local name = entry[1] .. ' - ' .. entry[2]
        return {
          value = entry,
          display = name,
          ordinal = name,
        }
      end,
    },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt_bufnr, _)
      -- NOTE: Reload theme while typing
      vim.schedule(function()
        api.nvim_create_autocmd('TextChangedI', {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              local entry = action_state.get_selected_entry().value
              local theme = entry[1]
              local style = entry[2]

              reload_theme(theme, style)
            end
          end,
        })
      end)

      --NOTE: Reload theme on cycling ( -1 )
      actions.move_selection_previous:replace(function()
        action_set.shift_selection(prompt_bufnr, -1)

        local entry = action_state.get_selected_entry().value
        local theme = entry[1]
        local style = entry[2]

        reload_theme(theme, style)
      end)

      -- NOTE: Reload theme on cycling ( 1 )
      actions.move_selection_next:replace(function()
        action_set.shift_selection(prompt_bufnr, 1)

        local entry = action_state.get_selected_entry().value
        local theme = entry[1]
        local style = entry[2]

        reload_theme(theme, style)
      end)

      -- NOTE: Save theme to options on enter
      actions.select_default:replace(function()
        if action_state.get_selected_entry() then
          local OPTIONS_FILE_PATH = '/lua/options.lua'

          local entry = action_state.get_selected_entry().value
          local options = dofile(vim.fn.stdpath 'config' .. OPTIONS_FILE_PATH)

          local old_theme = options.ui.theme.name
          local old_style = options.ui.theme.style

          local update_theme = {
            [old_theme] = entry[1],
            [old_style] = entry[2],
          }

          for old, new in pairs(update_theme) do
            require('fiend.helpers').replace_word(old, new)
          end

          actions.close(prompt_bufnr)
        end
      end)

      return true
    end,
  })

  picker:find()
end

return M
