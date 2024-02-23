return {
	{
		-- Highlight annotations like TODO, FIXME, etc.
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("todo-comments").setup()

			-- Add keymap to search for TODOs with telescope
			vim.keymap.set(
				"n",
				"<leader>tt",
				":TodoTelescope keywords=TODO theme=ivy path_display={'smart'}<CR>",
				{ noremap = true, desc = "Search for TODOs" }
			)
		end,
	},
	{
		-- Bookmark lines and annotate them
		"MattesGroeger/vim-bookmarks",
		event = "VeryLazy",
		init = function()
			vim.g.bookmark_no_default_key_mappings = 1
			vim.g.bookmark_sign = "󰃀 "
			vim.g.bookmark_annotation_sign = "󱖯 "
		end,
		config = function()
			vim.keymap.set("n", "mm", "<Plug>BookmarkToggle", { noremap = true, desc = "Toggle bookmark" })
			vim.keymap.set("n", "mi", "<Plug>BookmarkAnnotate", { noremap = true, desc = "Bookmark with annotation" })
			vim.keymap.set(
				"n",
				"mc",
				"<Plug>BookmarkClear",
				{ noremap = true, desc = "Clear bookmarks in current buffer" }
			)
			vim.keymap.set("n", "mx", "<Plug>BookmarkClearAll", { noremap = true, desc = "Clear all bookmarks" })
		end,
	},
	{
		-- Show bookmarks in telescope
		"tom-anders/telescope-vim-bookmarks.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("vim_bookmarks")

			vim.keymap.set(
				"n",
				"<leader>mm",
				":Telescope vim_bookmarks current_file theme=ivy<CR>",
				{ noremap = true, silent = true, desc = "Show bookmarks in current file" }
			)
			vim.keymap.set(
				"n",
				"<leader>aa",
				":Telescope vim_bookmarks all theme=ivy<CR>",
				{ noremap = true, silent = true, desc = "Show all bookmarks" }
			)
		end,
	},
}
