return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs = {
          change       = { numhl = 'GitSignsChangeNr' },
          delete       = { numhl = 'GitSignsDeleteNr' },
          topdelete    = { numhl = 'GitSignsDeleteNr' },
          changedelete = { numhl = 'GitSignsChangeNr' },
          untracked    = { numhl = 'GitSignsAddNr'    },
        },
        signcolumn = false,
        numhl = true,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 300,
        },
      }
    end,
    event = { 'VeryLazy' },
  },
}

