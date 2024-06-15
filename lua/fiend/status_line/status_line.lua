local fn = vim.fn
local M = {}

local function get_git_branch()
  local git_branch = fn.systemlist('git rev-parse --abbrev-ref HEAD 2>/dev/null')[1]

  if git_branch == nil or git_branch == '' then
    git_branch = ''
  else
    git_branch = '  ' .. '[' .. git_branch .. '] '
  end

  return git_branch
end

function M.status_line()
  local file = fn.expand '%:t'
  local dir = fn.expand '%:h:t'
  local modified = vim.bo.modified and '[+]' or '' -- Shows [+] if the file is modified, otherwise empty
  local git_branch = get_git_branch()

  return dir .. '/' .. file .. ' ' .. git_branch .. modified
end

return M
