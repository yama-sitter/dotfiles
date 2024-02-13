return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup()

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"tsserver",
					"ruby_ls",
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
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup()

			require("mason-null-ls").setup({
				ensure_installed = { "cspell", "stylua", "markuplint", "eslint_d", "prettierd" },
				automatic_installation = true,
				methods = {
					code_actions = false,
				},
			})

			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
						condition = function()
							return vim.fn.executable("cspell") > 0
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
						condition = function()
							return vim.fn.executable("markuplint") > 0
						end,
					}),
					null_ls.builtins.diagnostics.eslint_d.with({
						prefer_local = "node_modules/.bin",
						condition = function()
							return vim.fn.executable("eslint_d") > 0
						end,
					}),
					null_ls.builtins.formatting.prettierd.with({
						prefer_local = "node_modules/.bin",
						condition = function()
							return vim.fn.executable("prettierd") > 0
						end,
					}),
				},
				-- Diagnostic sources are run when exiting insert mode
				update_in_insert = false,
				on_attach = function(client, bufnr)
					-- Format on save
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = true })
							end,
						})
					end

					-- Disable inline diagnostics
					vim.diagnostic.config({
						virtual_text = false,
					})

					vim.keymap.set("n", "<leader>fm", function()
						vim.lsp.buf.format({ async = true })
					end)
				end,
			})
		end,
	},
}
