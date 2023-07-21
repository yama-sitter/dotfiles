local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
map('n', '<Space>', '', {})

local options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Buffers
map('n', '<C-l>', ':bn<cr>', options)
map('n', '<C-h>', ':bp<cr>', options)
map('n', '<C-q>', ':b#<cr>:bd#<cr>', options)

