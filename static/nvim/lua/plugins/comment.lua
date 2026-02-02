return {
  "numToStr/Comment.nvim",
  version = false,
  config = function()
    require("Comment").setup({
      ignore = "^$",
      -- toggler = {
      --   line = "<leader>gl",
      --   block = "<leader>cb",
      -- },
      -- opleader = {
      --   line = '<leader>c',
      --   block = '<leader>b',
      -- },
    })
  end,
}
