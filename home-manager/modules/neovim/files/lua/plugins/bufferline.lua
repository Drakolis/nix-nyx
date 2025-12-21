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

    -- Navigate tabs in BufferLine
    vim.keymap.set('n', '<leader><left>', ':BufferLineCyclePrev<CR>')
    vim.keymap.set('n', '<leader><right>', ':BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<leader>h', ':BufferLineCyclePrev<CR>')
    vim.keymap.set('n', '<leader>l', ':BufferLineCycleNext<CR>')
    vim.keymap.set('n', '<leader>w', ':bd<CR>')
    vim.keymap.set('n', '<c-[>', ':BufferLineCyclePrev<CR>')
    vim.keymap.set('n', '<c-]>', ':BufferLineCycleNext<CR>')
  end
}
