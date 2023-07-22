local settings = {
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'kkharji/lspsaga.nvim',
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
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = settings[server_name],
          }
        end,
      }
    end,
  },
}

