return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = 'close',
              ["<C-j>"] = 'move_selection_next',
              ["<C-k>"] = 'move_selection_previous',
            },
            n = {
              ["q"] = 'close',
            },
          },
        },
        pickers = {
          find_files = {
            theme = 'dropdown',
          },
          buffers = {
            theme = 'dropdown',
          },
          live_grep = {
            theme = 'dropdown',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = false,
            override_file_sorter = true,
            case_mode = 'smart_case',
          }
        },
      }

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>f', builtin.find_files, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
    end,
  },
}

