return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local colors = require '../colors'

      vim.cmd.colorscheme "catppuccin-mocha"
      -- vim.cmd('hi guibg='..colors.background)
    end
  }
}
