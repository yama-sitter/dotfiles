local settings = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

-- For Front-end setting
local eslint = {
  lintCommand = 'eslint --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %rror %m',
  },
}
local stylelint = {
  lintCommand = './node_modules/.bin/stylelint --stdin-filepath ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %m [%t%*[a-z]]',
  }
}
local markuplint = {
  lintCommand = './node_modules/.bin/markuplint --problem-only --allow-warnings ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f:%l:%c: %m [%t%*[a-z]]',
  }
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
          'html',
          'cssls',
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
          'html',
          'css',
          'typescript',
          'typescriptreact',
          'javascript',
          'javacriptreact',
        },
        settings = {
          rootMarkers = { '.git/' },
          languages = {
            javascript = { eslint, prettier, stylelint },
            javascriptreact = { eslint, prettier, markuplint },
            typescript = { eslint, prettier, stylelint },
            typescriptreact = { eslint, prettier, markuplint },
          },
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>', { buffer = bufnr })

          -- Format on save
          if (client.server_capabilities.documentFormattingProvider) then
            vim.api.nvim_create_augroup('AutoFormat', {})
            vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
              group = 'AutoFormat',
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end

          -- Disable inline diagnostics
          vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics, {
              virtual_text = false
            }
          )
        end,
      }
    end,
  },
}
