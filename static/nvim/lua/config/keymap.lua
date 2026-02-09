vim.g.mapleader = " "

-- makes current file executable
vim.keymap.set(
  "n",
  "<leader>x",
  ":silent !chmod +x % >/dev/null 2>&1<CR>:lua print('File is now executable.')<CR>",
  { noremap = true, silent = true }
)

-- append line below to current line with J
vim.keymap.set("n", "J", "mzJ`z")

-- keeps search term in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replaces current word on the entire file
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace the word in the file" }
)
vim.keymap.set(
  "v",
  "<leader>/",
  'y/\\V<C-r>"<CR>',
  { desc = "Yank and search selection" }
)
vim.keymap.set("n", "<leader>/", '/\\V<C-r>"<CR>', { desc = "Search yanked" })

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to clipboard" }) -- copy
vim.keymap.set({ "n", "x" }, "<leader>Y", '"+Y', { desc = "Copy to clipboard" }) -- copy line
vim.keymap.set(
  { "n", "x" },
  "<leader>p",
  '"+p',
  { desc = "Paste clipboard after" }
) -- paste
vim.keymap.set(
  { "n", "x" },
  "<leader>P",
  '"+P',
  { desc = "Paste clipboard before" }
) -- paste

-- Delete text without yanking
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_d')

-- Move selected text up and down with N and E
vim.keymap.set(
  "v",
  "<A-up>",
  ":m '<-2<CR>gv=gv",
  { desc = "Move selection up" }
)
vim.keymap.set(
  "v",
  "<A-down>",
  ":m '>+1<CR>gv=gv",
  { desc = "Move selection down" }
)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set(
  "v",
  "<A-j>",
  ":m '>+1<CR>gv=gv",
  { desc = "Move selection down" }
)

-- Move the current line in normal mode
vim.keymap.set("n", "<A-up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Select all text in current buffer
vim.keymap.set(
  "n",
  "<leader>a",
  ":keepjumps normal! ggVG<CR>",
  { desc = "Select all" }
)

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
vim.keymap.set(
  "n",
  "<leader><",
  ":vertical resize -2<CR>",
  { desc = "Decrease window width" }
)
vim.keymap.set(
  "n",
  "<leader>>",
  ":vertical resize +2<CR>",
  { desc = "Increase window width" }
)

-- Buffer navigation
vim.keymap.set("n", "<C-[>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-]>", ":bnext<CR>", { desc = "Next buffer" })

-- Quick save and quit
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Clear search highlighting
vim.keymap.set(
  "n",
  "<Esc>",
  ":nohlsearch<CR>",
  { desc = "Clear search highlighting" }
)

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
