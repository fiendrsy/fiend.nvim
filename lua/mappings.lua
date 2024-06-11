local K = require('fiend.helpers').keymaps
local C = require('fiend.helpers').commands
local M = {}

local function buffers()
  -- NOTE: Mapping for bufferline
  K.register('n', {
    ['<Tab>'] = C.BL_NEXT_TAB,
    ['<S-Tab>'] = C.BL_PREV_TAB,
    ['<S-w>'] = C.BL_CLOSE_TAB,
  })
end

local function navigations()
  local builtin = require 'telescope.builtin'

  -- NOTE: Mappings for telescope native actions
  K.register('n', {
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
  -- keymaps.register('n', {
  --   ['<leader>pt'] = require('theming.theme_picker').open_picker,
  -- })

  -- NOTE: Mappings for oil
  K.register('n', {
    ['<leader>e'] = require('oil').toggle_float,
  })
end

local function debugger()
  local dap = require 'dap'
  local dapui = require 'dapui'

  -- NOTE: Mappings for dap
  K.register('n', {
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
  K.register('n', {
    ['<leader>ww'] = require('conform').format,
    ['<leader>w'] = C.SAVE_FILE,
    ['<Esc>'] = C.CLEAR_SEARCH_HL,
  })

  K.register('v', {
    ['J'] = C.DOWNWARD_LINE,
    ['K'] = C.UPWARD_LINE,
  })
end

M.completion = function()
  local cmp = require 'cmp'

  return cmp.mapping.preset.insert {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }
end

M.lsp = function(event)
  local builtin = require 'telescope.builtin'
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  K.register('n', {
    ['gD'] = builtin.lsp_definitions,
    ['gr'] = builtin.lsp_references,
    ['gi'] = builtin.lsp_implementations,
    ['<leader>D'] = builtin.lsp_type_definitions,
    ['<leader>ds'] = builtin.lsp_document_symbols,
    ['<leader>ws'] = builtin.lsp_dynamic_workspace_symbols,
    ['<leader>rr'] = vim.lsp.buf.rename,
    ['<leader>ca'] = vim.lsp.buf.code_action,
    ['K'] = vim.lsp.buf.hover,
    ['gd'] = vim.lsp.buf.declaration,
  })

  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    K.register('n', {
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
