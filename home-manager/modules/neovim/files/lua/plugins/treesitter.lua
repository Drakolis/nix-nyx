return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = 'main',
    config = function()
      local plugin = require("nvim-treesitter")
      plugin.install({ "rust", "javascript", "terraform", "lua", "nix", "java", "python" })
    end
  }
}
