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
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
}

vim.opt.number = true -- line numbers
vim.opt.relativenumber = true -- relative line numbers
vim.opt.mouse = "a" -- mouse actions to allow
vim.opt.ignorecase = true -- search options
vim.opt.smartcase = true -- search options
vim.opt.hlsearch = false -- don't highlight search results
vim.opt.incsearch = true -- incremental search
vim.opt.wrap = false -- wrap lines around
vim.opt.breakindent = true -- how to indent wrapped lines
vim.opt.tabstop = 2 -- tab character size
vim.opt.softtabstop = 2 -- tab character size
vim.opt.shiftwidth = 2 -- indent size with >> and <<
vim.opt.expandtab = true -- replace tabs with spaces
vim.opt.smartindent = true -- smart indentation
vim.opt.autoindent = true -- auto indentation

-- Better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Better search
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Better backup/swap/undo
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Better display
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.laststatus = 3 -- global statusline

vim.g.python_recommended_style = 0

