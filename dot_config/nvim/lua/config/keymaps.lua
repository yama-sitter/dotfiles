local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
map('n', '<Space>', '', {})

options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)
