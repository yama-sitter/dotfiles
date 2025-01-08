return {
	{
		-- Display git signs in the sign column and provide useful command to use git
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
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
		keys = {
			{ "<leader>gs", ":TigStatus<CR>", noremap = true, silent = true, desc = "Show git status" },
			{ "<leader>gb", ":TigBlame<CR>", noremap = true, silent = true, desc = "Show git blame" },
		},
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
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gl", ":GitLink!<CR>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
}
