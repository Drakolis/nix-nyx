return { "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    windows = {
      position = "left",  -- Options: "right", "left", "top", "bottom"
      width = 30,  -- Percentage of available width
      wrap = true,
    },

    providers = {
      openai = {
        endpoint = "https://api.scaleway.ai/v1",
        model = "qwen3-235b-a22b-instruct-2507",
        extra_request_body = {
          max_completion_tokens = 8192,
          reasoning_effort = "medium",
        },
      }
    }
  },
  build = "make",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" }
}
