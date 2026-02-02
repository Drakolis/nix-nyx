return {
	"tpope/vim-fugitive",
	cmd = { "Git", "G" },
	keys = {
		{ "<leader>gs", "<cmd>Git<cr>", desc = "Git status" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
		{ "<leader>gP", "<cmd>Git push<cr>", desc = "Git push" },
		{ "<leader>gp", "<cmd>Git pull<cr>", desc = "Git pull" },
		{ "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
		{ "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git show file diff" },
	},
}
