require("config.functions")

return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-file-browser.nvim",
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

		vim.keymap.set("v", "<leader>ff", function()
			local text = vim.GetVisualSelection()
			builtin.current_buffer_fuzzy_find({ default_text = text })
		end, opts)
		vim.keymap.set("v", "<leader>gg", function()
			local text = vim.GetVisualSelection()
			builtin.live_grep({ default_text = text })
		end, opts)
	end,
}
