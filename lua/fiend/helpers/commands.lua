local M = {}

M.SAVE_FILE = '<CMD>silent! w<CR>'

M.CLEAR_SEARCH_HL = '<CMD>nohlsearch<CR>'

M.UPWARD_LINE = [[<CMD>m-2<CR>gv=gv]]

M.DOWNWARD_LINE = [[<CMD>m'>+1<CR>gv=gv]]

M.BL_PREV_TAB = [[<CMD>bp<CR>]]

M.BL_NEXT_TAB = [[<CMD>bn<CR>]]

M.BL_CLOSE_TAB = [[<CMD>bp<BAR>bd #<CR>]]

return M
