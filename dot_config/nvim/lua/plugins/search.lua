return {
	{
		-- Fuzzy finder
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					file_ignore_patterns = {
						"package%-lock.json",
						"node%_modules",
						"yarn.lock",
						".yarn",
						"storybook%-static",
					},
					mappings = {
						i = {
							["<C-w>"] = "close",
							["<C-q>"] = "close",
							["<C-f>"] = actions.add_to_qflist + actions.open_qflist,
							["<C-j>"] = "move_selection_next",
							["<C-k>"] = "move_selection_previous",
						},
						n = {
							["<C-w>"] = "close",
							["<C-q>"] = "close",
							["<C-f>"] = actions.add_to_qflist + actions.open_qflist,
						},
					},
				},
				pickers = {
					live_grep = { theme = "ivy" },
					find_files = { theme = "ivy" },
					buffers = { theme = "ivy" },
					current_buffer_fuzzy_find = { theme = "ivy" },
					help_tags = { theme = "ivy" },
					keymaps = { theme = "ivy" },
					diagnostics = { theme = "ivy", line_width = "full" },
					lsp_references = { theme = "ivy", show_line = false },
					lsp_definitions = { theme = "ivy", show_line = false },
					lsp_type_definitions = { theme = "ivy", show_line = false },
				},
				extensions = {
					file_browser = {
						hijack_netrw = true,
					},
				},
			})

			telescope.load_extension("file_browser")
			telescope.load_extension("live_grep_args")

			local builtin = require("telescope.builtin")
			local function find_files()
				builtin.find_files({ find_command = { "rg", "--files", "--hidden", "-g", "!.git" } })
			end

			local opts = { noremap = true }
			vim.keymap.set("n", "<leader>oo", find_files, opts)
			vim.keymap.set("n", "<leader>uu", builtin.buffers, opts)
			vim.keymap.set("n", "<leader>ff", builtin.current_buffer_fuzzy_find, opts)
			vim.keymap.set("n", "<leader>hh", builtin.help_tags, opts)
			vim.keymap.set("n", "<leader>kk", builtin.keymaps, opts)
			vim.keymap.set("n", "<leader>ll", builtin.diagnostics, opts)
			vim.keymap.set("n", "<leader>rr", builtin.lsp_references, opts)
			vim.keymap.set("n", "<leader>dd", builtin.lsp_definitions, opts)
			vim.keymap.set("n", "<leader>bb", ":Telescope file_browser theme=ivy<CR>", opts)
			vim.keymap.set("n", "<leader>gg", builtin.live_grep, opts)
			vim.keymap.set(
				"n",
				"<leader>ga",
				":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"
			)

			require("config.functions")

			vim.keymap.set("v", "<leader>ff", function()
				local text = vim.GetVisualSelection()
				builtin.current_buffer_fuzzy_find({ default_text = text })
			end, opts)
			vim.keymap.set("v", "<leader>gg", function()
				local text = vim.GetVisualSelection()
				builtin.live_grep({ default_text = text })
			end, opts)
		end,
	},
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
				"<leader>td",
				":TodoTelescope keywords=TODO theme=ivy path_display={'smart'}<CR>",
				{ noremap = true, silent = true, desc = "Search for TODOs" }
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
			vim.keymap.set(
				"n",
				"mm",
				"<Plug>BookmarkToggle",
				{ noremap = true, silent = true, desc = "Toggle bookmark" }
			)
			vim.keymap.set(
				"n",
				"mi",
				"<Plug>BookmarkAnnotate",
				{ noremap = true, silent = true, desc = "Bookmark with annotation" }
			)
			vim.keymap.set(
				"n",
				"mc",
				"<Plug>BookmarkClear",
				{ noremap = true, silent = true, desc = "Clear bookmarks in current buffer" }
			)
			vim.keymap.set(
				"n",
				"mx",
				"<Plug>BookmarkClearAll",
				{ noremap = true, silent = true, desc = "Clear all bookmarks" }
			)
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
				"<leader>ma",
				":Telescope vim_bookmarks all theme=ivy<CR>",
				{ noremap = true, silent = true, desc = "Show all bookmarks" }
			)
		end,
	},
	{
		-- File browser
		"stevearc/oil.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local oil = require("oil")

			oil.setup({
				default_file_explorer = true,
				trash_command = "trash",
				view_options = {
					show_hidden = true,
				},
				use_default_keymaps = true,
				keymaps = {
					["?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					["<C-p>"] = "actions.preview",
					["<C-q>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["<C-g>"] = "actions.parent",
					["<C-w>"] = "actions.open_cwd",
					["<C-t>"] = "actions.toggle_hidden",
				},
			})

			local options = { noremap = true }
			vim.keymap.set("n", "<leader>of", function()
				oil.open()
			end, options)
		end,
	},
}
