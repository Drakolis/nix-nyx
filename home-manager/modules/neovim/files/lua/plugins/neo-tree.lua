return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
    vim.keymap.set("n", "<leader>bf", ":Neotree filesystem toggle right<CR>", {})
    vim.keymap.set("n", "<leader>bg", ":Neotree git_status toggle right<CR>", {})
		vim.keymap.set("n", "<leader>bb", ":Neotree buffers toggle right<CR>", {})
	end,
}
