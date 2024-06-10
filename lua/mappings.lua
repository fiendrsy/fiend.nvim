local set = vim.keymap.set

set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Save current file
set('n', '<leader>w', '<cmd>silent! w <CR>')

-- FIXME:
-- Move current line up (don't work)
set('v', 'K', ":m '>-2<CR>gv=gv")

-- FIXME: 
-- Move current line down (don't work)
set('v', 'J', ":m '>+1<CR>gv=gv")

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
