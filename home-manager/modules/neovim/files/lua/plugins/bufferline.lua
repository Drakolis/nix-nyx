return {
  'akinsho/bufferline.nvim',
  version = false,
  config = function()
    local colors = require '../colors'
    require('bufferline').setup({
      options = {
        mode = 'buffers',
        numbers = 'ordinal',
        diagnostics = "nvim_lsp",
        offsets = {
          {filetype = 'NvimTree', text_align = 'center'}
        },
        indicator = {
          icon = '▌',
        },
        color_icons = true,
      },
      -- :help bufferline-highlights
      highlights = {
        fill = {
          bg = colors.panel,
        },
        buffer_selected = {
          italic = false
        },
        indicator_selected = {
          fg = colors.primary,
          italic = false
        }
      }
    })
  end
}
