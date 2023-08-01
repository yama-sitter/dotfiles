return {
  'smoka7/multicursors.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'smoka7/hydra.nvim',
  },
  opts = {},
  cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  keys = {
    {
      mode = { 'v', 'n' },
      '<leader>m',
      '<cmd>MCstart<CR>',
      desc = 'Create a selection for selcted text or word under the cursor',
    },
  },
}
