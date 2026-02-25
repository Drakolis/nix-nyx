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
    keys = {
      {
        "<Leader>bd",
        ":DBUIToggle<CR>",
        desc = "Open Database Panel",
      },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_default_query = 'SELECT * FROM "{table}" LIMIT 200'
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
