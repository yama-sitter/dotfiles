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
}
