return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			local cmp = require("cmp")

			cmp.setup({
				completion = {
					completeopt = "menu, menuone, noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-s>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = require("lspkind").cmp_format({
						mode = "text",
					}),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			-- Disable tab mapping
			-- vim.g.copilot_no_tab_map = true

			vim.keymap.set(
				"i",
				"<C-g>",
				'copilot#Accept("<CR>")',
				{ silent = true, expr = true, script = true, replace_keycodes = false }
			)

			local opts = { noremap = true, silent = true }
			vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", opts)
			vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", opts)
			vim.keymap.set("i", "<C-o>", "<Plug>(copilot-dismiss)", opts)
			vim.keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)", opts)
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons",
			"github/copilot.vim",
		},
		build = "make",
		opts = {
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			behaviour = {
				auto_suggestions = true,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = true,
				support_paste_from_clipboard = true,
				minimize_diff = true,
			},
			windows = {
				position = "right",
				width = 30,
				sidebar_header = {
					align = "center",
					rounded = false,
				},
				ask = {
					floating = true,
					start_insert = true,
					border = "rounded",
				},
			},
			copilot = {
				model = "gpt-4o-2024-05-13",
				max_tokens = 4096,
			},
			mappings = {
				submit = {
					normal = "<CR>",
					insert = "<C-y>",
				},
			},
		},
	},
}
