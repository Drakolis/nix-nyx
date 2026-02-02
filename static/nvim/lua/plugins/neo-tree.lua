return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>bf", ":Neotree filesystem toggle<CR>", {})
		vim.keymap.set("n", "<leader>bg", ":Neotree git_status toggle<CR>", {})
		vim.keymap.set("n", "<leader>bb", ":Neotree buffers toggle<CR>", {})
		vim.keymap.set(
			"n",
			"<leader>bs",
			":Neotree document_symbols toggle<CR>",
			{}
		)
		vim.keymap.set("n", "<leader>b", ":Neotree last<CR>", {})
		vim.keymap.set("n", "<leader>br", ":Neotree last reveal<CR>", {})
		require("neo-tree").setup({
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			window = { position = "right", width = 30 },
		})
	end,
}
