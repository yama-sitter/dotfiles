local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
map('n', '<Space>', '', {})

options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Buffers
map('n', '<C-l>', ':bnext<cr>', options)
map('n', '<C-h>', ':bprevious<cr>', options)
map('n', '<C-q>', '<cmd>b#<cr><cmd>bd#<cr>', options)

