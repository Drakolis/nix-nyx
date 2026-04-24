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
vim.opt.incsearch = true -- incremental search
vim.opt.wrap = false -- wrap lines around
vim.opt.breakindent = true -- how to indent wrapped lines
vim.opt.tabstop = 2 -- tab character size
vim.opt.softtabstop = 2 -- tab character size
vim.opt.shiftwidth = 2 -- indent size with >> and <<
vim.opt.expandtab = true -- replace tabs with spaces
vim.opt.smartindent = true -- smart indentation
vim.opt.autoindent = true -- auto indentation

vim.opt.confirm = true -- ask for confirmation if has unsaved changes

vim.opt.list = true -- Change how some characters (whitespace) will look
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.inccommand = "split"

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
vim.opt.laststatus = 3 -- global statusline

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Teest shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = { float = true },
})

vim.o.title = true

local function update_title()
  vim.o.titlestring = "nvim %{fnamemodify(getcwd(), ':~')}"
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged", "BufEnter" }, {
  callback = update_title,
})
