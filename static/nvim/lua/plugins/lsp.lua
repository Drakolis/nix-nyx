return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/nvim-cmp",
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        nix = { "nixpkgs_fmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "80" },
        },
        prettier = {
          prepend_args = { "--print-width", "80" },
        },
        stylua = {
          prepend_args = { "--column-width", "80" },
        },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 
      "hrsh7th/cmp-nvim-lsp",
      "stevearc/conform.nvim"
    },
    config = function()
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Better LSP keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = {buffer = event.buf}
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          -- Use conform for formatting instead of LSP
          vim.keymap.set('n', '<leader>cf', function()
            require("conform").format({ async = true, lsp_fallback = true })
          end, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end,
      })

      local lspconfig = require("lspconfig")
      
      -- Setup LSP servers (installed via Nix)
      lspconfig.lua_ls.setup({ 
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      
      lspconfig.nil_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          ['nil'] = {
            formatting = { command = { "nixpkgs-fmt" } },
          },
        },
      })
      
      lspconfig.pyright.setup({ capabilities = lsp_capabilities })
      lspconfig.ts_ls.setup({ 
        capabilities = lsp_capabilities,
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        }
      })
      lspconfig.html.setup({ capabilities = lsp_capabilities })
      lspconfig.cssls.setup({ capabilities = lsp_capabilities })
      lspconfig.eslint.setup({ capabilities = lsp_capabilities })
    end
  }
}
