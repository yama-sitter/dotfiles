return {
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
        hi BqfPreviewBorder guifg=#5e81ac ctermfg=71
      ]])
      
      -- Allow 2-byte character icons to be displayed
      vim.fn.setcellwidths {
        { 0x2501, 0x2501, 1 },
        { 0x2503, 0x2503, 1 },
        { 0x250f, 0x250f, 1 },
        { 0x2513, 0x2513, 1 },
        { 0x2517, 0x2517, 1 },
        { 0x251b, 0x251b, 1 },
      }

      require('bqf').setup {
        preview = {
          border = {'┏', '━', '┓', '┃', '┛', '━', '┗', '┃'},
        },
      }
    end,
  },
}

