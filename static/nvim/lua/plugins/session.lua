return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = vim.opt.sessionoptions:get(), -- sessionoptions used for saving
    pre_save = function()
      -- Close neo-tree before saving session
      vim.cmd("Neotree close")
    end,
    save_empty = false, -- don't save if there are no open file buffers
  },
  keys = {
    {
      "<leader>qr",
      function()
        require("persistence").load()
      end,
      desc = "Restore session for cwd",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore last session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't save current session",
    },
    {
      "<leader>qs",
      function()
        require("persistence").select()
      end,
      desc = "Select a session...",
    },
  },
}
