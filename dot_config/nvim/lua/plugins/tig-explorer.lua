return {
  {
    'iberianpig/tig-explorer.vim',
    event = 'VeryLazy',
    dependencies = {
      'rbgrouleff/bclose.vim',
    },
    config = function ()
      local options = { noremap = true }
      vim.keymap.set('n', '<leader>ts', ':TigStatus<CR>', options)
      vim.keymap.set('n', '<leader>tb', ':TigBlame<CR>', options)
    end,
  },
}
