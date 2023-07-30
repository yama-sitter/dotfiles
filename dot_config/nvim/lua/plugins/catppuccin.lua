return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        term_colors = true,
        integrations = {
          gitsigns = true,
          lsp_saga = true,
          mason = true,
          cmp = true,
          treesitter = true,
          aerial = true,
          noice = true,
          notify = true,
          telescope = {
            enabled = true,
          },
        },
      }
      vim.cmd[[colorscheme catppuccin]]
    end,
  }
}
