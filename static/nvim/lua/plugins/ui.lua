return {

  -- Highlight colors in code
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        css = { rgb_fn = true },
        html = { names = false },
      })
    end,
  },

  -- Enhanced cursor line
  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = {
          enable = true,
          timeout = 1000,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },

  -- Scrollbar with search and diagnostic indicators
  {
    "petertriho/nvim-scrollbar",
    config = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30,
          color = colors.surface0,
          color_nr = nil,
          highlight = "CursorColumn",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = {
            text = "•",
            priority = 0,
            gui = nil,
            color = colors.purple,
            cterm = nil,
            color_nr = nil,
            highlight = "Normal",
          },
          Search = {
            text = { "-", "=" },
            priority = 1,
            gui = nil,
            color = colors.orange,
            cterm = nil,
            color_nr = nil,
            highlight = "Search",
          },
          Error = {
            text = { "-", "=" },
            priority = 2,
            gui = nil,
            color = colors.red,
            cterm = nil,
            color_nr = nil,
            highlight = "DiagnosticVirtualTextError",
          },
          Warn = {
            text = { "-", "=" },
            priority = 3,
            gui = nil,
            color = colors.yellow,
            cterm = nil,
            color_nr = nil,
            highlight = "DiagnosticVirtualTextWarn",
          },
          Info = {
            text = { "-", "=" },
            priority = 4,
            gui = nil,
            color = colors.sky,
            cterm = nil,
            color_nr = nil,
            highlight = "DiagnosticVirtualTextInfo",
          },
          Hint = {
            text = { "-", "=" },
            priority = 5,
            gui = nil,
            color = colors.teal,
            cterm = nil,
            color_nr = nil,
            highlight = "DiagnosticVirtualTextHint",
          },
          Misc = {
            text = { "-", "=" },
            priority = 6,
            gui = nil,
            color = colors.purple,
            cterm = nil,
            color_nr = nil,
            highlight = "Normal",
          },
          GitAdd = {
            text = "┆",
            priority = 7,
            gui = nil,
            color = colors.green,
            cterm = nil,
            color_nr = nil,
            highlight = "GitSignsAdd",
          },
          GitChange = {
            text = "┆",
            priority = 7,
            gui = nil,
            color = colors.yellow,
            cterm = nil,
            color_nr = nil,
            highlight = "GitSignsChange",
          },
          GitDelete = {
            text = "▁",
            priority = 7,
            gui = nil,
            color = colors.red,
            cterm = nil,
            color_nr = nil,
            highlight = "GitSignsDelete",
          },
        },
        excluded_buftypes = {
          "terminal",
        },
        excluded_filetypes = {
          "cmp_docs",
          "cmp_menu",
          "noice",
          "prompt",
          "TelescopePrompt",
          "neo-tree",
        },
        autocmd = {
          render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
          },
          clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
          },
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = true,
        },
      })
    end,
  },

  -- Enhanced indent guides with subtle rainbow colors
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Muted rainbow colors for regular indent guides
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#6c4a4a" })     -- Muted red
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#6c6249" })  -- Muted yellow
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#4a5c6c" })    -- Muted blue
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#6c5a49" })  -- Muted orange
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#4a6c4a" })   -- Muted green
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#5c4a6c" })  -- Muted violet
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#4a6c6c" })    -- Muted cyan

        vim.api.nvim_set_hl(0, "ScopeHighlight", { fg = "#b4befe" })    -- Muted cyan
      end)

      require("ibl").setup({
        indent = {
          highlight = highlight,
          char = "│",
        },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = false,
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
          injected_languages = false,
          highlight = "ScopeHighlight",
          priority = 500,
        },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}