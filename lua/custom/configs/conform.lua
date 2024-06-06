-- Init mappings for conform
require('custom.mappings').conform()

require('conform').setup {
  notify_on_error = false,

  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { { 'prettierd', 'prettier' } },
  },
}
