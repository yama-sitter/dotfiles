return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local oil = require('oil')

    oil.setup {
      default_file_explorer = true,
      trash_command = 'trash',
      view_options = {
        show_hidden = true,
      },
      use_default_keymaps = true,
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-p>'] = 'actions.preview',
        ['<C-q>'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['<C-g>'] = 'actions.parent',
        ['<C-w>'] = 'actions.open_cwd',
        ['<C-t>'] = 'actions.toggle_hidden',
      },
    }

    local options = { noremap = true }
    vim.keymap.set('n', '<leader>fo', function()
      oil.open()
    end, options)
  end,
}
