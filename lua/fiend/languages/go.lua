local autocmd = vim.api.nvim_create_autocmd
local s = vim.bo

local M = {}

local function indent()
  autocmd('FileType', {
    pattern = 'go',
    callback = function()
      s.tabstop = 4
      s.shiftwidth = 4
      s.expandtab = true
    end,
  })
end

M.setup = function()
  indent()
end

return M
