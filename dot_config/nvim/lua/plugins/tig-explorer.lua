return {
  {
    'iberianpig/tig-explorer.vim',
    event = 'VeryLazy',
    dependencies = {
      'rbgrouleff/bclose.vim',
    },
    config = function ()
      local options = { noremap = true }
      vim.keymap.set('n', '<leader>t', ':Tig<CR>', options)
    end,
  },
}

