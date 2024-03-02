return {
	{
		-- Apply sintax highlight to the file
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"vim",
					"vimdoc",
					"query",
					"comment",
					"diff",
					"json",
					"yaml",
					"toml",
					"tsv",
					"csv",
					"markdown",
					"git_config",
					"git_rebase",
					"gitattributes",
					"gitcommit",
					"gitignore",
					"lua",
					"html",
					"css",
					"typescript",
					"javascript",
					"tsx",
					"ruby",
					"dockerfile",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		-- Highlight the current word under the cursor
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("illuminate").configure()
		end,
	},
	{
		-- Close and rename html tags automatically with treesitter
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},
	{
		-- Close brackets, quotes, etc automatically
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
	},
	{
		-- Insert comments
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {
			toggler = {
				line = "<leader>\\\\",
			},
			opleader = {
				line = "<leader>\\\\",
			},
		},
	},
	{
    -- Facilitates operation of enclosing with/eliminating certain characters
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})

			-- Usage
			-- surr*ound_words             ysiw)           (surround_words)
			-- *make strings               ys$"            "make strings"
			-- [delete ar*ound me!]        ds]             delete around me!
			-- remove <b>HTML t*ags</b>    dst             remove HTML tags
			-- 'change quot*es'            cs'"            "change quotes"
			-- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
			-- delete(functi*on calls)     dsf             function calls
		end,
	},
}
