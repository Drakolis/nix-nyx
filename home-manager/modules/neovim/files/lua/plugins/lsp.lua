return {
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').quick_lint_js.setup{}
  end
}
