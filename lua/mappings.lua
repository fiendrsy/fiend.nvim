local keymaps = require 'fiend.helpers.keymaps'
local M = {}

local function buffers()
  -- NOTE: Mapping for bufferline
  keymaps.register('n', {
    ['<Tab>'] = [[<CMD>bn<CR>]],
    ['<S-Tab>'] = [[<CMD>bp<CR>]],
    ['S-w'] = [[<CMD>bp<BAR>bd #<CR>]],
  })
end

local function navigations()
  local builtin = require 'telescope.builtin'

  -- NOTE: Mappings for telescope native actions
  keymaps.register('n', {
    ['<leader>ff'] = builtin.find_files,
    ['<leader>gs'] = builtin.grep_string,
    ['<leader>fg'] = builtin.live_grep,
    ['<leader>gf'] = builtin.git_files,
    ['<leader>bf'] = builtin.current_buffer_fuzzy_find,

    ['<leader>g.'] = function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,

    ['<leader>/'] = function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
  })

  -- NOTE: Mapping for pick colorscheme
  keymaps.register('n', {
    ['<leader>pt'] = [[<CMD>lua require'theming.theme_picker'.open_picker()<CR>]],
  })

  -- NOTE: Mappings for oil
  keymaps.register('n', {
    -- Open parent directory
    ['-'] = '<CMD>Oil<CR>',

    -- Toggle oil
    ['<leader>e'] = require('oil').toggle_float,
  })
end

local function debugger()
  local dap = require 'dap'
  local dapui = require 'dapui'

  -- NOTE: Mappings for dap
  keymaps.register('n', {
    ['<F5>'] = dap.continue,
    ['<F1>'] = dap.step_into,
    ['<F2>'] = dap.step_over,
    ['<F3>'] = dap.step_out,
    ['<leader>b'] = dap.toggle_breakpoint,
    ['<leader>B'] = function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end,
    ['<F7>'] = dapui.toggle,
  })
end

-- NOTE: Mappings that work with editor
local function editor_actions()
  keymaps.register('n', {
    -- Save current file
    ['<leader>w'] = '<CMD>w<CR>',

    -- Format current file
    ['<leader>ww'] = '<CMD>lua require("conform").format()<CR>',

    -- Disable highlight for search via ?
    ['<Esc>'] = '<CMD>nohlsearch<CR>',
  })

  keymaps.register('v', {
    -- Move current line (inside cursor) downward
    ['J'] = [[<CMD>m'>+1<CR>gv=gv]],

    -- Move current line (inside cursor) upward
    ['K'] = [[<CMD>m-2<CR>gv=gv]],
  })
end

M.completion = function()
  local cmp = require 'cmp'

  return cmp.mapping.preset.insert {
    -- Select the next item
    ['<Tab>'] = cmp.mapping.select_next_item(),

    -- Select the previous item
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

    -- Accept currently selected item
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }
end

M.lsp = function(event)
  local builtin = require 'telescope.builtin'
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  keymaps.register('n', {
    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    ['gD'] = builtin.lsp_definitions,

    -- Find references for the word under your cursor.
    ['gr'] = builtin.lsp_references,

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    ['gi'] = builtin.lsp_implementations,

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    ['<leader>D'] = builtin.lsp_type_definitions,

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    ['<leader>ds'] = builtin.lsp_document_symbols,

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    ['<leader>ws'] = builtin.lsp_dynamic_workspace_symbols,

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    ['<leader>rr'] = vim.lsp.buf.rename,

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    ['<leader>ca'] = vim.lsp.buf.code_action,

    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    ['K'] = vim.lsp.buf.hover,

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    ['gd'] = vim.lsp.buf.declaration,
  })
  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    keymaps.register('n', {
      ['<leader>th'] = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end,
    })
  end
end

M.oil = function()
  return {
    ['g?'] = 'actions.show_help',
    ['o'] = 'actions.select',
    ['<C-s>'] = 'actions.select_vsplit',
    ['<C-h>'] = 'actions.select_split',
    ['<C-t>'] = 'actions.select_tab',
    ['<C-p>'] = 'actions.preview',
    ['<C-c>'] = 'actions.close',
    ['<C-l>'] = 'actions.refresh',
    ['-'] = 'actions.parent',
    ['_'] = 'actions.open_cwd',
    ['`'] = 'actions.cd',
    ['~'] = 'actions.tcd',
    ['gs'] = 'actions.change_sort',
    ['gx'] = 'actions.open_external',
    ['g.'] = 'actions.toggle_hidden',
    ['g\\'] = 'actions.toggle_trash',
  }
end

M.setup = function()
  buffers()
  navigations()
  debugger()
  editor_actions()
end

return M
