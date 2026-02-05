return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "pattern" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "flake.nix",
      },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = false,
      silent_chdir = false,
      scope_chdir = "global",
      datapath = vim.fn.stdpath("data"),
    })

    -- Integration with Telescope
    require("telescope").load_extension("projects")

    vim.keymap.set(
      "n",
      "<leader>fp",
      ":Telescope projects<CR>",
      { desc = "Find projects" }
    )
  end,
}
