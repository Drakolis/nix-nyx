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
        python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
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
        nix = { "nixfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--print-width",
            "80",
            "--tab-width",
            "2",
            "--use-tabs",
            "false",
          },
        },
        stylua = {
          prepend_args = {
            "--column-width",
            "80",
            "--indent-width",
            "2",
            "--indent-type",
            "Spaces",
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "stevearc/conform.nvim",
    },
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Better LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { buffer = event.buf, desc = "Go to definition" }
          )
          --[[ vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            { buffer = event.buf, desc = "References..." }
          ) ]]
          --[[ vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            { buffer = event.buf, desc = "Show symbol info" }
          ) ]]
          vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            { buffer = event.buf, desc = "Code actions" }
          )
          -- Use conform for formatting instead of LSP
          vim.keymap.set("n", "<leader>cf", function()
            require("conform").format({
              async = true,
              lsp_fallback = true,
            })
          end, { desc = "Format file" })
          vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            { buffer = event.buf, desc = "Rename symbol" }
          )
          --[[ vim.keymap.set(
            "n",
            "<leader>d",
            vim.diagnostic.open_float,
            { buffer = event.buf, desc = "Open diagnostics" }
          )
          vim.keymap.set(
            "n",
            "[d",
            vim.diagnostic.goto_prev,
            { buffer = event.buf, desc = "Diagnostics: Next" }
          )
          vim.keymap.set(
            "n",
            "]d",
            vim.diagnostic.goto_next,
            { buffer = event.buf, desc = "Diagnostics: Previous" }
          ) ]]
        end,
      })

      local lspconfig = require("lspconfig")

      -- Setup LSP servers (installed via Nix)
      lspconfig.lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      lspconfig.nil_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          ["nil"] = {
            formatting = { command = { "nixpkgs-fmt" } },
          },
        },
      })

      lspconfig.pyright.setup({ capabilities = lsp_capabilities })
      lspconfig.ts_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      })
      lspconfig.html.setup({ capabilities = lsp_capabilities })
      lspconfig.cssls.setup({ capabilities = lsp_capabilities })
      lspconfig.eslint.setup({ capabilities = lsp_capabilities })
    end,
  },
}
