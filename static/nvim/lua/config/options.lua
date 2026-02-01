vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.mouse = 'a' -- mouse actions to allow
vim.opt.ignorecase = true -- search options
vim.opt.smartcase = true -- search options
-- vim.opt.hlsearch = false
vim.opt.wrap = false -- wrap lines around
vim.opt.breakindent = true -- how to indent wrapped lines
vim.opt.tabstop = 2 -- tab character size
vim.opt.softtabstop = 2 -- tab character size
vim.opt.shiftwidth = 2 -- indent size with >> and <<
vim.opt.expandtab = true -- replace tabs with spaces

vim.g.python_recommended_style = 0

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = false  -- Change for spaces
  end,
})
