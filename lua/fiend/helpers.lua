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

M.replace_word = function(old, new)
  local OPTIONS_FILE_PATH = vim.fn.stdpath 'config' .. '/lua/' .. 'options.lua'

  local added_pattern = string.gsub(old, '-', '%%-') -- Add % before - if exists
  local file = io.open(OPTIONS_FILE_PATH, 'r')

  if file == nil then
    print(file, 'Value is equal nil! helpers.lua/replace_word line:56 ')

    return
  end

  local new_content = file:read('*all'):gsub(added_pattern, new, 1)

  file = io.open(OPTIONS_FILE_PATH, 'w')

  if file == nil then
    print(file, 'Value is equal nil! helpers.lua/replace_word line:65 ')

    return
  end

  file:write(new_content)
  file:close()
end

return M
