return {
	{
		-- Move cursor with small steps
		"phaazon/hop.nvim",
		event = "VeryLazy",
		branch = "v2",
		config = function()
			require("hop").setup()

			vim.keymap.set(
				"",
				"<leader>jj",
				":HopWord<CR>",
				{ noremap = true, silent = true, desc = "Move cursor to word with small steps" }
			)
		end,
	},
	{
    -- Move cursor without considering symbols
		"kana/vim-smartword",
		event = "VeryLazy",
		config = function()
			local options = { noremap = true }
			vim.keymap.set("", "w", "<Plug>(smartword-w)", options)
			vim.keymap.set("", "b", "<Plug>(smartword-b)", options)
			vim.keymap.set("", "e", "<Plug>(smartword-e)", options)
			vim.keymap.set("", "ge", "<Plug>(smartword-ge)", options)
		end,
	},
}
