return {
  -- Database interface
  {
    "tpope/vim-dadbod",
  },
  -- UI for vim-dadbod
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Set up keybindings
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_default_query = 'SELECT * FROM "{table}" LIMIT 200'
      vim.keymap.set(
        "n",
        "<leader>db",
        ":DBUIToggle<CR>",
        { desc = "Open Database Panel" }
      )
    end,
  },
  -- Completion for vim-dadbod
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = {
      "tpope/vim-dadbod",
      "hrsh7th/nvim-cmp",
    },
    ft = { "sql", "mysql", "plsql" },
    config = function()
      -- Add dadbod completion to nvim-cmp
      require("cmp").setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end,
  },
}
