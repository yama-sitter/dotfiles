return {
  {
    'kevinhwang91/nvim-bqf',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
        hi BqfPreviewBorder guifg=#5e81ac ctermfg=71
      ]])
      
      -- The base 'ambiwidth' is 2, but only the ruled lines should be set to 1
      -- If this is not set, 'nvim_open_win()' throws an error on the bqf preview screen
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

