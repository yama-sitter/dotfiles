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
			vim.keymap.set("n", "<leader>gs", ":TigStatus<CR>", options)
			vim.keymap.set("n", "<leader>gb", ":TigBlame<CR>", options)
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		config = function()
			require("diffview").setup({})

			local function toggle_diff_history()
				local file_name = vim.fn.expand("%:p")
				if string.match(file_name, "^diffview.+") then
					vim.cmd("tabclose")
				else
					vim.cmd("DiffviewFileHistory %")
				end
			end

			vim.keymap.set(
				"n",
				"<leader>gh",
				toggle_diff_history,
				{ noremap = true, silent = true, desc = "Show file history" }
			)
		end,
	},
}
