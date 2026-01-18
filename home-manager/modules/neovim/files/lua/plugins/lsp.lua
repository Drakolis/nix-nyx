return {
  {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      local cmp = require('cmp')

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          -- Change this line to your preferred key, e.g., <C-y>, <Tab>, or <C-Space>
          ['<C-CR>'] = cmp.mapping.confirm({ select = true }),  -- Accepts selected item
          -- Or disable <CR> entirely for newline fallback:
          -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),  -- Keep abort
          ['<C-Space>'] = cmp.mapping.complete(),  -- Trigger menu
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },  -- Powered by cmp-nvim-lsp
        }, {
          { name = 'buffer' },
        }),
      })

      -- Prevent multiple instance of lsp servers
      -- if file is sourced again
      if vim.g.lsp_setup_ready == nil then
        vim.g.lsp_setup_ready = true

        -- See :help lspconfig-setup
        vim.lsp.config("html", {capabilities = lsp_capabilities,})
        vim.lsp.config("cssls", {capabilities = lsp_capabilities,})
        vim.lsp.config("eslint", {capabilities = lsp_capabilities,})
        vim.lsp.config("ts_ls", {
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
