-- Add to static/nvim/lua/plugins/session.lua
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
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
