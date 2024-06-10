local set = vim.keymap.set
local mappings = {}

mappings.telescope = function()
  local builtin = require 'telescope.builtin'

  set('n', '<leader>ff', builtin.find_files)
  set('n', '<leader>gs', builtin.grep_string)
  set('n', '<leader>fg', builtin.live_grep)
  set('n', '<leader>gf', builtin.git_files)
  set('n', '<leader>bf', builtin.current_buffer_fuzzy_find)

  set('n', '<leader>g.', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end)

  set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end)
end

mappings.bufferline = function()
  -- The next tab
  set('n', '<Tab>', '<CMD>bn<CR>')

  -- The previous tab
  set('n', '<S-Tab>', '<CMD>bp<CR>')

  -- Close active tab
  set('n', '<S-w>', '<CMD>bp<BAR>bd #<CR>')
end

mappings.completion = function()
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

mappings.lsp = function(event)
  local builtin = require 'telescope.builtin'
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  set('n', 'gD', builtin.lsp_definitions)

  -- Find references for the word under your cursor.
  set('n', 'gr', builtin.lsp_references)

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  set('n', 'gi', builtin.lsp_implementations)

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  set('n', '<leader>D', builtin.lsp_type_definitions)

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  set('n', '<leader>ds', builtin.lsp_document_symbols)

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols)

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  set('n', '<leader>rr', vim.lsp.buf.rename)

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  set('n', '<leader>ca', vim.lsp.buf.code_action)

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  set('n', 'K', vim.lsp.buf.hover)

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  set('n', 'gd', vim.lsp.buf.declaration)

  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    set('n', '<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end)
  end
end

mappings.conform = function()
  set('n', '<leader>ww', ':lua require("conform").format()<CR>', { noremap = true, silent = true })
end

mappings.oil = function()
  -- Open parent directory
  set('n', '-', '<CMD>Oil<CR>')

  -- Toggle oil
  set('n', '<leader>e', require('oil').toggle_float)

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

mappings.dap = function()
  local dap = require 'dap'
  local dapui = require 'dapui'

  set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
end

return mappings
