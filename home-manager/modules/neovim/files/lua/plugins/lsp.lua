return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Prevent multiple instance of lsp servers
      -- if file is sourced again
      if vim.g.lsp_setup_ready == nil then
        vim.g.lsp_setup_ready = true

        -- See :help lspconfig-setup
        lspconfig.html.setup({capabilities = lsp_capabilities,})
        lspconfig.cssls.setup({capabilities = lsp_capabilities,})
        lspconfig.eslint.setup({capabilities = lsp_capabilities,})
        lspconfig.tsserver.setup({
          capabilities = lsp_capabilities,
          settings = {
            completions = {
              completeFunctionCalls = true
            }
          },
        })
      end
    end
  }
}
