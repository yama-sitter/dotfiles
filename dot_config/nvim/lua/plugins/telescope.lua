return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    event = 'VeryLazy',
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
       'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('telescope').load_extension('file_browser')

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
          live_grep = {
            theme = 'dropdown',
            additional_args = function()
              return { '--hidden' }
            end,
          },
          find_files            = { theme = 'dropdown' },
          buffers               = { theme = 'dropdown' },
          help_tags             = { theme = 'dropdown' },
          keymaps               = { theme = 'dropdown' },
          diagnostics           = { theme = 'dropdown' },
          lsp_references        = { theme = 'dropdown' },
          lsp_definitions       = { theme = 'dropdown' },
          lsp_type_definitions  = { theme = 'dropdown' },
        },
        extensions = {
          file_browser = {
            theme = 'dropdown',
            hijack_netrw = true,
          },
        },
      }

      local builtin = require('telescope.builtin')
      local function find_files()
        builtin.find_files(({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}))
      end

      local opts = { noremap = true }
      vim.keymap.set('n', '<leader>o', find_files, opts)
      vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
      vim.keymap.set('n', '<leader>g', builtin.live_grep, opts)
      vim.keymap.set('n', '<leader>h', builtin.help_tags, opts)
      vim.keymap.set('n', '<leader>k', builtin.keymaps, opts)
      vim.keymap.set('n', '<leader>d', builtin.diagnostics, opts)
      vim.keymap.set('n', '<leader>r', builtin.lsp_references, opts)
      vim.keymap.set('n', '<leader>n', builtin.lsp_definitions, opts)
      vim.keymap.set('n', '<leader>t', builtin.lsp_type_definitions, opts)
      vim.keymap.set('n', '<leader>f', ':Telescope file_browser<CR>', opts)
    end,
  },
}

