return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local colors = require("../colors")

			local drakolisTheme = {
				normal = {
					a = {
						fg = colors.textInverted,
						bg = colors.modeNormal,
						gui = "bold",
					},
					b = { fg = colors.mauve, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},

				command = {
					a = {
						fg = colors.textInverted,
						bg = colors.modeCommand,
						gui = "bold",
					},
					b = { fg = colors.modeCommand, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},

				insert = {
					a = {
						fg = colors.textInverted,
						bg = colors.modeInsert,
						gui = "bold",
					},
					b = { fg = colors.modeInsert, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},

				visual = {
					a = {
						fg = colors.textInverted,
						bg = colors.modeVisual,
						gui = "bold",
					},
					b = { fg = colors.modeVisual, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},

				replace = {
					a = {
						fg = colors.textInverted,
						bg = colors.modeReplace,
						gui = "bold",
					},
					b = { fg = colors.modeReplace, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},

				inactive = {
					a = {
						fg = colors.text,
						bg = colors.modeInactive,
						gui = "bold",
					},
					b = { fg = colors.text, bg = colors.modeInactive },
					c = { fg = colors.text, bg = colors.panel },
				},
			}

			local mode = {
				"mode",
				separator = {
					left = "",
					right = "",
				},
				left_padding = 6,
			}

			local location = {
				"location",
				separator = {
					left = "",
					right = "",
				},
				right_padding = 6,
			}

			local progress = {
				"progress",
				separator = {
					left = "",
				},
			}

			local filetype = {
				"filetype",
				colored = true,
			}

			local cwd = {
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
				end,
				colored = true,
				separator = {
					left = "",
					right = "",
				},
			}

			local neotree = {
				sections = { lualine_a = { cwd } },
				colored = true,
				filetypes = { "neo-tree" },
			}

			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = drakolisTheme,
					component_separators = {
						left = "/",
						right = "/",
					},
					section_separators = {
						left = "",
						right = "",
					},
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},
				sections = {
					lualine_a = { mode },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "fileformat", "encoding", filetype },
					lualine_y = { progress },
					lualine_z = { location },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				winbar = {},
				inactive_winbar = {},
				extensions = { neotree, "fugitive" },
			})
		end,
	},
}
