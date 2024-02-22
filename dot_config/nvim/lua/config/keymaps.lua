require("config.functions")

local map = vim.keymap.set

vim.g.mapleader = " "
map("n", "<Space>", "", {})

local options = { noremap = true, silent = true }

map("n", "<leader><esc>", ":nohlsearch<cr>", options)

-- Buffers
map("n", "<C-l>", ":bn<CR>", options)
map("n", "<C-h>", ":bp<CR>", options)

map("n", "<C-q>", vim.CloseBuffer, options)

-- Copy name of current file to clipboard
map("n", "<leader>cp", ':let @* = expand("%:p")<CR>', options)

-- Grep word under cursor with vimgrep
map("n", "<C-g>", ":vimgrep <cword> % | cw<CR>", { noremap = true })
map("v", "<C-g>", function()
	local text = vim.GetVisualSelection()
	vim.cmd(":vimgrep " .. text .. " % | cw")
end, { noremap = true })
