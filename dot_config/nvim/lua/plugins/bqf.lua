return {
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
        hi BqfPreviewBorder guifg=#5e81ac ctermfg=71
      ]])

      require('bqf').setup {
        preview = {
          border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
        },
      }
    end,
  },
}
