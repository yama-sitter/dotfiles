return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup()

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = {
					"bashls",
					"lua_ls",
					"tsserver",
          "stylelint_lsp",
					"solargraph",
				},
				automatic_installation = true,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local settings = {
				lua_ls = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			}

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						settings = settings[server_name],
					})
				end,
			})

			-- Disable inline diagnostics
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
	{
		-- Run tools like formatters and linters like LSP
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup()

			require("mason-null-ls").setup({
				ensure_installed = { "cspell", "shellcheck", "stylua", "markuplint", "eslint_d", "prettierd" },
				automatic_installation = true,
				methods = {
					code_actions = false,
				},
			})

			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.cspell.with({
						config = {
							find_json = function(cwd)
								return vim.fn.expand(cwd .. "/.vscode/cspell.json")
							end,
						},
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity["WARN"]
						end,
						condition = function(utils)
							return vim.fn.executable("cspell") > 0
								and utils.root_has_file({
									".vscode/cspell.json",
								})
						end,
					}),
					null_ls.builtins.formatting.stylua.with({
						condition = function()
							return vim.fn.executable("stylua") > 0
						end,
					}),
					null_ls.builtins.diagnostics.markuplint.with({
						filetypes = { "html", "javascriptreact", "typescriptreact" },
						prefer_local = "node_modules/.bin",
						condition = function(utils)
							return vim.fn.executable("markuplint") > 0
								and utils.root_has_file({
									".markuplintrc",
									".markuplintrc.json",
									".markuplintrc.yaml",
									".markuplintrc.yml",
									".markuplintrc.js",
									".markuplintrc.ts",
								})
						end,
					}),
					null_ls.builtins.diagnostics.eslint_d.with({
						prefer_local = "node_modules/.bin",
						condition = function(utils)
							return vim.fn.executable("eslint_d") > 0
								and utils.root_has_file({
									".eslintrc.js",
									".eslintrc.json",
									".eslintrc.yaml",
									".eslintrc.yml",
									".eslintrc",
								})
						end,
					}),
					null_ls.builtins.formatting.prettierd.with({
						prefer_local = "node_modules/.bin",
						condition = function(utils)
							return vim.fn.executable("prettierd") > 0
								and utils.root_has_file({
									".prettierrc",
									".prettierrc.json",
									".prettierrc.yaml",
									".prettierrc.yml",
									".prettierrc.js",
								})
						end,
					}),
				},
				-- Diagnostic sources are run when exiting insert mode
				update_in_insert = false,
				on_attach = function(client, bufnr)
					-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

					-- Format on save
					-- if client.supports_method("textDocument/formatting") then
					-- 	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					-- 	vim.api.nvim_create_autocmd("BufWritePre", {
					-- 		group = augroup,
					-- 		buffer = bufnr,
					-- 		callback = function()
					-- 			vim.lsp.buf.format({ async = false })
					-- 		end,
					-- 	})
					-- end

					vim.keymap.set("n", "<leader>fm", function()
						vim.lsp.buf.format({ async = false })
					end)
				end,
			})
		end,
	},
	{
		-- Make lsp usefull
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		event = { "VeryLazy" },
		config = function()
			require("lspsaga").setup({})

			-- vim.api.nvim_create_augroup('ShowLineDiagnostics', {})
			-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
			--   group = 'ShowLineDiagnostics',
			--   callback = function()
			--     require('lspsaga.diagnostic.show'):show_diagnostics({ line = true })
			--   end,
			-- })

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "J", ":Lspsaga show_line_diagnostics<CR>", opts)
			vim.keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
			vim.keymap.set("n", "<C-k>", ":Lspsaga diagnostic_jump_prev<CR>", opts)
			vim.keymap.set("n", "<C-j>", ":Lspsaga diagnostic_jump_next<CR>", opts)
		end,
	},
	{
		-- Show diagnostics of all files
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		config = function()
			local trouble = require("trouble")
			vim.keymap.set("n", "<leader>xx", function()
				trouble.toggle()
			end, { noremap = true })
		end,
	},
}
