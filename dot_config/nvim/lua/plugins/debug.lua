return {
	{
		"mfussenegger/nvim-dap",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mxsdev/nvim-dap-vscode-js",
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
			{
				"microsoft/vscode-chrome-debug",
				build = "npm install --legacy-peer-deps && npm run build",
			},
			"suketa/nvim-dap-ruby",
		},
		config = function()
			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node", "pwa-chrome" },
			})

			local dap = require("dap")

			dap.adapters.chrome = {
				type = "executable",
				command = "node",
				args = { vim.fn.stdpath("data") .. "/lazy/vscode-chrome-debug/out/src/chromeDebug.js" },
			}

			for _, language in ipairs({
				"javascript",
				"typescript",
			}) do
				dap.configurations[language] = {
					{
						name = "Launch file",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
				}
			end

			require("dap-ruby").setup()

			require("dapui").setup({
				layouts = {
					{
						elements = {
							{ id = "repl", size = 0.15 },
							{ id = "stacks", size = 0.2 },
							{ id = "watches", size = 0.2 },
							{ id = "scopes", size = 0.35 },
							{ id = "breakpoints", size = 0.1 },
						},
						size = 0.4,
						position = "left",
					},
					{
						elements = { "console" },
						size = 0.25,
						position = "bottom",
					},
				},
			})

			local opts = { noremap = true, silent = true }
			local keymap = vim.keymap.set
			keymap("n", "<leader>c", ":DapContinue<CR>", opts)
			keymap("n", "<leader>b", ":DapToggleBreakpoint<CR>", opts)
			keymap("n", "<leader>v", ":DapStepOver<CR>", opts)
			keymap("n", "<leader>i", ":DapStepInto<CR>", opts)
			keymap("n", "<leader>o", ":DapStepOut<CR>", opts)
			keymap("n", "<leader>r", ":DapToggleRepl<CR>", opts)
			keymap("n", "<leader>d", ':lua require("dapui").toggle({ reset = true })<CR>', opts)
			keymap("n", "<leader>wa", ':lua require("dapui").elements.watches.add()<CR>', opts)
			keymap("n", "<leader>wr", ':lua require("dapui").elements.watches.remove()<CR>', opts)
			keymap("n", "<leader>e", ':lua require("dapui").eval()<CR>', opts)
		end,
	},
	{
		"David-Kunz/jester",
		ft = {
			"typescript",
			"typescriptreact",
			"javascript",
			"javacriptreact",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("jester").setup({
				path_to_jest_run = "npx jest",
				terminal_cmd = ":split | terminal",
			})

			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<leader>ja", ':lua require"jester".run_file()<CR>', opts)
			vim.keymap.set("n", "<leader>js", ':lua require"jester".run()<CR>', opts)
		end,
	},
	{
		"dmmulroy/tsc.nvim",
		event = "VeryLazy",
		config = function()
			require("tsc").setup()
		end,
	},
}
