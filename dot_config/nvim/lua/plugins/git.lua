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

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<C-]>", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
				map("n", "<C-[>", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
			end,
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
