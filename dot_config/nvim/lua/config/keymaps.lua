local map = vim.keymap.set

vim.g.mapleader = ' '
map('n', '<Space>', '', {})

local options = { noremap = true, silent = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)

-- Buffers
map('n', '<C-l>', ':bn<CR>', options)
map('n', '<C-h>', ':bp<CR>', options)

function vim.CloseBuffer()
  if vim.bo.buftype == 'terminal' then
    vim.cmd('bw!')
  else
    vim.cmd('bw')
  end
end
map('n', '<C-q>', vim.CloseBuffer, options)

-- Copy name of current file to clipboard
map('n', '<leader>cp', ':let @* = expand("%:p")<CR>', options)
