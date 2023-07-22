return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    lazy = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
    },
    config = function()
      require('telescope').load_extension 'file_browser'

      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = 'close',
              ['<C-j>'] = 'move_selection_next',
              ['<C-k>'] = 'move_selection_previous',
            },
            n = {
              ['q'] = 'close',
            },
          },
        },
        pickers = {
          find_files  = { theme = 'dropdown' },
          buffers     = { theme = 'dropdown' },
          live_grep   = { theme = 'dropdown' },
          help_tags   = { theme = 'dropdown' },
          keymaps     = { theme = 'dropdown' },
          diagnostics = { theme = 'dropdown' },
        },
        extensions = {
          file_browser = {
            theme = 'dropdown',
            hijack_netrw = true,
          },
        },
      }

      local builtin = require('telescope.builtin')
      local opts = { noremap = true }
      vim.keymap.set('n', '<leader>o', builtin.find_files, opts)
      vim.keymap.set('n', '<leader>u', builtin.buffers, opts)
      vim.keymap.set('n', '<leader>g', builtin.live_grep, opts)
      vim.keymap.set('n', '<leader>h', builtin.help_tags, opts)
      vim.keymap.set('n', '<leader>k', builtin.keymaps, opts)
      vim.keymap.set('n', '<leader>d', builtin.diagnostics, opts)
      vim.keymap.set('n', '<leader>f', ':Telescope file_browser<CR>', opts)
    end,
  },
}

