return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'vim',
          'lua',
          'typescript',
          'tsx',
        },
        highlight = {
          enable = true,
        },
      }
    end,
  },
}

