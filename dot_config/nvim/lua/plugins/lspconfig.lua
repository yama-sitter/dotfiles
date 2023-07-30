local settings = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

local eslint = {
  lintCommand = './node_modules/.bin/eslint --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %rror %m',
  },
}
local prettier = {
  formatCommand = './node_modules/.bin/prettier --stdin-filepath ${INPUT}',
  formatStdin = true,
}

return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'mattn/efm-langserver',
    },
    config = function()
      require('mason').setup {}

      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup {
        ensure_installed = {
          'lua_ls',
          'tsserver',
        },
        automatic_installation = true,
      }

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            settings = settings[server_name],
          }
        end
      }

      require('lspconfig').efm.setup {
        init_options = { documentFormatting = true },
        filetypes = {
          'typescript',
          'typescriptreact',
          'javascript',
          'javacriptreact',
        },
        settings = {
          rootMarkers = { '.git/' },
          languages = {
            javascript = { eslint, prettier },
            javascriptreact = { eslint, prettier },
            typescript = { eslint, prettier },
            typescriptreact = { eslint, prettier },
          },
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>m', '<cmd>lua vim.lsp.buf.format()<CR>', { buffer = bufnr })

          -- Format on save
          if (client.server_capabilities.documentFormattingProvider) then
            vim.api.nvim_create_augroup('AutoFormat', {})
            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
              group = 'AutoFormat',
              pattern = {
                '*.ts',
                '*.tsx',
                '*.js',
                '*.jsx',
              },
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        end,
      }
    end,
  },
}
