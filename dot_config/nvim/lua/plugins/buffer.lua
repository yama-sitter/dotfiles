return {
	{
		-- Close buffer with delete
		"ojroques/nvim-bufdel",
		event = "VeryLazy",
		config = function()
			function CloseBuffer()
				if vim.bo.buftype == "terminal" then
					vim.cmd("bd!")
        elseif vim.bo.buftype == "quickfix" then
					vim.fn.setqflist({}, "r")
					vim.cmd("cclose")
				else
					vim.cmd("BufDel")
				end
			end

			vim.keymap.set("n", "<C-l>", ":bn<CR>", { noremap = true, silent = true, desc = "Next buffer" })
			vim.keymap.set("n", "<C-h>", ":bp<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
			vim.keymap.set("n", "<C-q>", CloseBuffer, { noremap = true, silent = true, desc = "Close buffer" })
		end,
	},
}
