require("config.functions")

local map = vim.keymap.set

vim.g.mapleader = " "
map("n", "<Space>", "", {})

local options = { noremap = true, silent = true }

map("n", "<leader><esc>", ":nohlsearch<cr>", options)

-- Copy name of current file to clipboard
map("n", "<leader>cp", ':let @* = expand("%:p")<CR>', options)

-- Grep word under cursor with vimgrep
map("n", "<C-g>", ":vimgrep <cword> % | cw<CR>", options)
map("v", "<C-g>", function()
	local text = vim.GetVisualSelection()
	vim.cmd(":vimgrep " .. text .. " % | cw")
end, options)
