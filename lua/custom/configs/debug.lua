local dap = require 'dap'
local dapui = require 'dapui'

-- Init mappings for dap
require('custom.mappings').dap()

require('mason-nvim-dap').setup {
  automatic_installation = true,

  handlers = {},

  ensure_installed = {
    -- Update this to ensure that you have the debuggers for the langs you want
    'delve',
  },
}

-- Dap UI setup
-- For more information, see |:help nvim-dap-ui|
dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Install golang specific config
require('dap-go').setup {
  delve = {
    detached = vim.fn.has 'win32' == 0,
  },
}
