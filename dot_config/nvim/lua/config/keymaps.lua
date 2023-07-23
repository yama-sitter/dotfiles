local map = vim.keymap.set

vim.g.mapleader = ' '
map('n', '<Space>', '', {})

local options = { noremap = true, silent = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Buffers
map('n', '<C-l>', ':bn<CR>', options)
map('n', '<C-h>', ':bp<CR>', options)
map('n', '<C-q>', ':bd<CR>', options)

