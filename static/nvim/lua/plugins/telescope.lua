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
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fc', builtin.command_history, { desc = 'Telescope command history' })
      vim.keymap.set('n', '<leader>f/', builtin.search_history, { desc = 'Telescope search history' })
      vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })
      vim.keymap.set('n', '<leader>fD', builtin.lsp_type_definitions, { desc = 'Telescope LSP type definitions' })
      vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})
      require("telescope").load_extension("ui-select")
    end,
  },
}
