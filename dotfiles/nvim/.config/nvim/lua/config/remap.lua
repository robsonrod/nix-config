local g = vim.g
local set = vim.keymap.set

g.mapleader = ","

set("n", "<leader>pv", vim.cmd.Ex)

-- escape
set('i', '<C-c>', '<Esc>')

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- undo/redo
set("i", "<C-z>", "<C-o>u")
set("i", "<C-r>", "<C-o><C-r>")

-- save
set("n", "<C-s>", ":w<CR>")
set("i", "<C-s>", "<C-o>:w<CR>")

-- quit
set("n", "<C-q>", ":q<CR>")
set("i", "<C-q>", "<C-o>:q<CR>")

--restart
set("n", "<leader>rst", ":restart<CR>")
set("i", "<leader>rst", "<C-o>:restart<CR>")

