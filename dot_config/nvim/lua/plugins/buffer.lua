return {
	{
		-- Allows quickly delete multiple buffers
		"kazhala/close-buffers.nvim",
		event = "VeryLazy",
		config = function()
			local function close_buffer()
				local file_name = vim.fn.expand("%:p")

				if vim.bo.buftype == "terminal" or vim.bo.buftype == "acwrite" then
					vim.cmd("bd!")
				elseif vim.bo.buftype == "quickfix" then
					vim.fn.setqflist({}, "r")
					vim.cmd("cclose")
				elseif string.match(file_name, "^diffview.+") then
					-- Allow to close the buffer which opened by diffview
					vim.cmd("tabclose")
				else
					vim.cmd("BWipeout! this")
				end
			end

			vim.keymap.set("n", "<C-l>", ":bn<CR>", { noremap = true, silent = true, desc = "Next buffer" })
			vim.keymap.set("n", "<C-h>", ":bp<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
			vim.keymap.set("n", "<C-q>", close_buffer, { noremap = true, silent = true, desc = "Close buffer" })
		end,
	},
}
