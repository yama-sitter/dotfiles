return {
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
}
