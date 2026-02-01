vim.g.mapleader = " "

-- makes current file executable
vim.keymap.set("n", "<leader>x", ":silent !chmod +x % >/dev/null 2>&1<CR>:lua print('File is now executable.')<CR>", { noremap = true, silent = true })

-- append line below to current line with J
vim.keymap.set("n", "J", "mzJ`z")

-- keeps search term in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replaces current word on the entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("v", "<leader>/", 'y/\\V<C-r>"<CR>')
vim.keymap.set("n", "<leader>/", '/\\V<C-r>"<CR>')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y') -- copy
vim.keymap.set({ 'n', 'x' }, '<leader>Y', '"+Y') -- copy line
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p') -- paste
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P') -- paste

-- Delete text without yanking
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'X', '"_d')

-- Move selected text up and down with N and E
vim.keymap.set("v", "<leader><up>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<leader><down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<leader>k", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<leader>j", ":m '>+1<CR>gv=gv")

-- Move the current line in normal mode
vim.keymap.set("n", "<leader><up>", ":m .-2<CR>==")
vim.keymap.set("n", "<leader><down>", ":m .+1<CR>==")
vim.keymap.set("n", "<leader>k", ":m .-2<CR>==")
vim.keymap.set("n", "<leader>j", ":m .+1<CR>==")

-- Select all text in current buffer
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<CR>')


