return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set(
        "n",
        "<leader>ff",
        builtin.find_files,
        { desc = "Find files" }
      )
      vim.keymap.set(
        "n",
        "<leader>fg",
        builtin.live_grep,
        { desc = "Live grep" }
      )
      vim.keymap.set(
        "n",
        "<leader>fb",
        builtin.buffers,
        { desc = "Find buffers" }
      )
      vim.keymap.set(
        "n",
        "<leader>fh",
        builtin.help_tags,
        { desc = "Find help tags" }
      )
      vim.keymap.set(
        "n",
        "<leader>fc",
        builtin.command_history,
        { desc = "Show command history" }
      )
      vim.keymap.set(
        "n",
        "<leader>fH",
        builtin.search_history,
        { desc = "Show search history" }
      )
      vim.keymap.set(
        "n",
        "<leader>fo",
        builtin.oldfiles,
        { desc = "Find old files" }
      )
      vim.keymap.set(
        "n",
        "<leader>ft",
        builtin.builtin,
        { desc = "Telescope methods" }
      )
      vim.keymap.set(
        "n",
        "<leader>fw",
        builtin.grep_string,
        { desc = "Search word" }
      )
      vim.keymap.set(
        "n",
        "<leader>fn",
        builtin.diagnostics,
        { desc = "Search diagnostics" }
      )
      require("telescope").load_extension("ui-select")

      vim.keymap.set(
        "n",
        "<leader>gb",
        builtin.git_branches,
        { desc = "Git branches" }
      )
      vim.keymap.set(
        "n",
        "<leader>gh",
        builtin.git_bcommits,
        { desc = "Git buffer commit history" }
      )
      vim.keymap.set(
        "n",
        "<leader>gH",
        builtin.git_commits,
        { desc = "Git commit history" }
      )

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup(
          "telescope-lsp-attach",
          { clear = true }
        ),
        callback = function(event)
          local buf = event.buf

          vim.keymap.set(
            "n",
            "<leader>fr",
            builtin.lsp_definitions,
            { buffer = buf, desc = "Find LSP references" }
          )
          vim.keymap.set(
            "n",
            "<leader>fi",
            builtin.lsp_implementations,
            { buffer = buf, desc = "Find LSP implementations" }
          )
          vim.keymap.set(
            "n",
            "<leader>fd",
            builtin.lsp_definitions,
            { buffer = buf, desc = "Find LSP definitions" }
          )
          vim.keymap.set(
            "n",
            "<leader>fD",
            builtin.lsp_type_definitions,
            { buffer = buf, desc = "Find LSP type definitions" }
          )
          vim.keymap.set(
            "n",
            "<leader>fs",
            builtin.lsp_document_symbols,
            { buffer = buf, desc = "Find LSP symbols" }
          )
          vim.keymap.set(
            "n",
            "<leader>fS",
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = "Find LSP workspace symbols" }
          )
        end,
      })

      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to  to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          })
        )
      end, { desc = "Search in current buffer" })
      vim.keymap.set("n", "<leader>f/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "Live grep in open files" })
    end,
  },
}
