local M = {
  commands = {},
  keymaps = {},
}

local api = vim.api

-- NOTE: Keymaps field
local function scope_to_table(scope)
  if type(scope) == 'table' then
    return scope
  end

  return {
    [1] = scope,
  }
end

M.keymaps.register = function(scopes, mappings, options)
  local opts
  if options == nil then
    opts = {
      nowait = true,
      silent = true,
      noremap = true,
    }
  else
    opts = options
  end

  for _, scope in pairs(scope_to_table(scopes)) do
    for key, value in pairs(mappings) do
      vim.keymap.set(scope, key, value, opts)
    end
  end
end

M.keymaps.register_bufnr = function(bufnr, scope, mappings)
  local options = { noremap = true, silent = true }

  for key, value in pairs(mappings) do
    api.nvim_buf_set_keymap(bufnr, scope, key, value, options)
  end
end

-- NOTE: Commands field
M.commands.SAVE_FILE = '<CMD>silent! w<CR>'
M.commands.CLEAR_SEARCH_HL = '<CMD>nohlsearch<CR>'
M.commands.UPWARD_LINE = [[<CMD>m-2<CR>gv=gv]]
M.commands.DOWNWARD_LINE = [[<CMD>m'>+1<CR>gv=gv]]
M.commands.BL_PREV_TAB = [[<CMD>bp<CR>]]
M.commands.BL_NEXT_TAB = [[<CMD>bn<CR>]]
M.commands.BL_CLOSE_TAB = [[<CMD>bp<BAR>bd #<CR>]]

return M
