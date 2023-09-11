return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'mxsdev/nvim-dap-vscode-js',
    {
      'microsoft/vscode-js-debug',
      build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    {
      'microsoft/vscode-chrome-debug',
      build = 'npm install --legacy-peer-deps && npm run build',
    },
  },
  config = function()
    require('dap-vscode-js').setup {
      debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome' },
    }

    local dap = require('dap')

    dap.adapters.chrome = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.stdpath('data') .. '/lazy/vscode-chrome-debug/out/src/chromeDebug.js' }
    }

    for _, language in ipairs({
      'javascript',
      'typescript',
    }) do
      dap.configurations[language] = {
        {
          name = 'Launch file',
          type = 'pwa-node',
          request = 'launch',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }
    end

    --[[ for _, language in ipairs({
      'javascriptreact',
      'typescriptreact',
    }) do
      dap.configurations[language] = {
        {
          name = 'Debug with Chrome',
          type = 'pwa-chrome',
          request = 'attach',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          port = 9222,
          webRoot = '${workspaceFolder}',
        },
      }
    end ]]

    -- require('dapui').setup()

    --[[ local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<leader>b', ':lua require("dapui").toggle()<CR>', opts) ]]
  end
}
