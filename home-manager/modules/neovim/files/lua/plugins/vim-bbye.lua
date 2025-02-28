return {
  'moll/vim-bbye',
  version = false,
  config = function()
    vim.keymap.set('n', '<leader>bc', '<cmd>Bdelete<CR>')
  end
}
