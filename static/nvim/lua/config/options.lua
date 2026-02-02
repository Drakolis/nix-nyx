vim.opt.undofile = true -- persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.updatetime = 50 -- faster completion
vim.opt.timeoutlen = 300 -- faster which-key
vim.opt.scrolloff = 8 -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- keep 8 columns left/right of cursor
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.colorcolumn = "80" -- show column at 80 chars
vim.opt.cursorline = true -- highlight current line
vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right
vim.opt.termguicolors = true -- enable 24-bit RGB colors

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.mouse = "a" -- mouse actions to allow
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
		vim.bo.expandtab = false -- Change for spaces
	end,
})
