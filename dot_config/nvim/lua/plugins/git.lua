return {
	{
		-- Display git signs in the sign column and provide useful command to use git
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				change = { numhl = "GitSignsChangeNr" },
				delete = { numhl = "GitSignsDeleteNr" },
				topdelete = { numhl = "GitSignsDeleteNr" },
				changedelete = { numhl = "GitSignsChangeNr" },
				untracked = { numhl = "GitSignsAddNr" },
			},
			signcolumn = false,
			numhl = true,

			current_line_blame = true,
			current_line_blame_opts = {
				delay = 300,
			},
		},
	},
	{
		-- Use tig from vim
		"iberianpig/tig-explorer.vim",
		event = "VeryLazy",
		dependencies = {
			"rbgrouleff/bclose.vim",
		},
		config = function()
			local options = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>ts", ":TigStatus<CR>", options)
			vim.keymap.set("n", "<leader>tb", ":TigBlame<CR>", options)
			vim.keymap.set("n", "<leader>to", ":TigOpenCurrentFile<CR>", options)
		end,
	},
}
