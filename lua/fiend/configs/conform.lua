require('conform').setup {
  notify_on_error = false,

  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'gofmt' },
    javascript = { { 'prettierd', 'prettier' } },
    typescript = { { 'prettierd', 'prettier' } },
    json = { 'prettier' },
  },
}
