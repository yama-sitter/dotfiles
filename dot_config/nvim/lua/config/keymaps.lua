local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
map('n', '<Space>', '', {})

local options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Buffers
map('n', '<C-l>', ':bn<CR>', options)
map('n', '<C-h>', ':bp<CR>', options)
map('n', '<C-q>', ':bd<CR>', options)

