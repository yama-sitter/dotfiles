return {
  'kana/vim-smartword',
  event = 'VeryLazy',
  config = function()
    local options = { noremap = true }
    vim.keymap.set('', 'w', '<Plug>(smartword-w)', options)
    vim.keymap.set('', 'b', '<Plug>(smartword-b)', options)
    vim.keymap.set('', 'e', '<Plug>(smartword-e)', options)
    vim.keymap.set('', 'ge', '<Plug>(smartword-ge)', options)
  end,
}
