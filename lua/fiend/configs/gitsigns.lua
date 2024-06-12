local ok, signs = pcall(require, 'gitsigns')

if not ok then
  return
end

signs.setup {
  signs = {
    add = { text = '▎' },
    change = { text = '▎' },
    delete = { text = '▎' },
    topdelete = { text = '▎' },
    changedelete = { text = '▎' },
  },
}
