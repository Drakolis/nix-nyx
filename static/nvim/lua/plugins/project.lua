return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
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
      silent_chdir = true,
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

