return {
  {
    'stevearc/aerial.nvim',
    enabled = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        '<leader>a',
        function()
          local aerial = require('aerial')
          aerial.toggle { focus = true }
        end,
      },
    },
    opts = {
      backends = {
        'treesitter',
        'lsp',
        'markdown',
        'man',
      },
      layout = {
        max_width = { 80, 0.5 },
        width = nil,
        min_width = 20,
        win_opts = {
          winblend = 30,
        },
        default_direction = 'float',
        placement = 'edge',
      },
      manage_folds = false,
      autojump = true,
      nerd_font = true,
      close_on_select = true,
      show_guides = true,
      float = {
        border = 'rounded',
        relative = 'win',
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
        override = function(conf, source_winid)
          conf.anchor = 'NE'
          conf.col = vim.fn.winwidth(source_winid)
          conf.row = 0
          return conf
        end,
      },
    },
  }
}
