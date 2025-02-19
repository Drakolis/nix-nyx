vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.relativenumber = true

-- makes current file executable
vim.keymap.set("n", "<leader>x", ":silent !chmod +x % >/dev/null 2>&1<CR>:lua print('File is now executable.')<CR>", { noremap = true, silent = true })

-- append line below to current line with J
vim.keymap.set("n", "J", "mzJ`z")

-- move selected text up and down with N and E
vim.keymap.set("v", "N", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "E", ":m '>+1<CR>gv=gv")

-- keeps search term in the middle of the page
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- allows to copy (yank) to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- replaces current word on the entire file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
