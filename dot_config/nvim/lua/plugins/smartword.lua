return {
  {
    'kana/vim-smartword',
    event = 'VeryLazy',
    config = function()
      local options = { noremap = true }
      vim.keymap.set('n', 'w', '<Plug>(smartword-w)', options)
      vim.keymap.set('n', 'b', '<Plug>(smartword-b)', options)
      vim.keymap.set('n', 'e', '<Plug>(smartword-e)', options)
      vim.keymap.set('n', 'ge', '<Plug>(smartword-ge)', options)
      vim.keymap.set('v', 'w', '<Plug>(smartword-w)', options)
      vim.keymap.set('v', 'b', '<Plug>(smartword-b)', options)
      vim.keymap.set('v', 'e', '<Plug>(smartword-e)', options)
      vim.keymap.set('v', 'ge', '<Plug>(smartword-ge)', options)
    end,
  },
}
