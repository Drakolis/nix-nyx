return {
  {
    "NMAC427/guess-indent.nvim",
  },
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
  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft["markdown"] = { "markdownlint" }

      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      lint.linters_by_ft["json"] = nil
      lint.linters_by_ft["markdown"] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWritePost", "InsertLeave" },
        {
          group = lint_augroup,
          callback = function()
            -- Only run the linter in buffers that you can modify in order to
            -- avoid superfluous noise, notably within the handy LSP pop-ups that
            -- describe the hovered symbol using Markdown.
            if vim.bo.modifiable then
              lint.try_lint()
            end
          end,
        }
      )
    end,
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
          vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            { buffer = event.buf, desc = "Show symbol info" }
          )
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
          vim.keymap.set(
            "n",
            "<leader>d",
            vim.diagnostic.open_float,
            { buffer = event.buf, desc = "Open diagnostics" }
          )
        end,
      })
      -- shared defaults for all servers, optional but neat
      vim.lsp.config("*", {
        capabilities = lsp_capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.lsp.config("nil_ls", {
        settings = {
          ["nil"] = {
            formatting = { command = { "nixpkgs-fmt" } },
          },
        },
      })

      vim.lsp.config("pyright", {})

      vim.lsp.config("ts_ls", {
        settings = {
          completions = {
            completeFunctionCalls = true,
          },
        },
      })

      vim.lsp.config("html", {})
      vim.lsp.config("cssls", {})
      vim.lsp.config("eslint", {})

      vim.lsp.enable({
        "lua_ls",
        "nil_ls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "eslint",
      })

      vim.lsp.config.qml = {
        cmd = { "qml-language-server" },
        filetypes = { "qml" },
        root_markers = { "qmldir", ".git" },
      }
      vim.lsp.enable("qml")
    end,
  },
}
