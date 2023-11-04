return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-file-browser.nvim',
  },
  config = function()
    require('telescope').load_extension('file_browser')

    require('telescope').setup {
      defaults = {
        path_display = { 'smart' },
        file_ignore_patterns = { 'node_modules' },
        mappings = {
          i = {
            ['<C-w>'] = 'close',
            ['<C-q>'] = 'close',
            ['<C-j>'] = 'move_selection_next',
            ['<C-k>'] = 'move_selection_previous',
          },
          n = {
            ['<C-w>'] = 'close',
            ['<C-q>'] = 'close',
          },
        },
      },
      pickers = {
        live_grep                 = {
          theme = 'dropdown',
          additional_args = function()
            return {
              '--hidden',
              '--no-ignore',
              '-g',
              '!package-lock.json',
              '-g',
              '!.git/*',
              '-g',
              '!.next/*',
            }
          end,
        },
        find_files                = { theme = 'ivy' },
        live_grep                 = { theme = 'ivy' },
        buffers                   = { theme = 'ivy' },
        current_buffer_fuzzy_find = { theme = 'ivy' },
        help_tags                 = { theme = 'ivy' },
        keymaps                   = { theme = 'ivy' },
        diagnostics               = { theme = 'ivy', line_width = 'full' },
        lsp_references            = { theme = 'ivy', show_line = false },
        lsp_definitions           = { theme = 'ivy', show_line = false },
        lsp_type_definitions      = { theme = 'ivy', show_line = false },
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
      builtin.find_files({ find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } })
    end

    local opts = { noremap = true }
    vim.keymap.set('n', '<leader>oo', find_files, opts)
    vim.keymap.set('n', '<leader>uu', builtin.buffers, opts)
    vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, opts)
    vim.keymap.set('n', '<leader>gg', builtin.live_grep, opts)
    vim.keymap.set('n', '<leader>hh', builtin.help_tags, opts)
    vim.keymap.set('n', '<leader>kk', builtin.keymaps, opts)
    vim.keymap.set('n', '<leader>ll', builtin.diagnostics, opts)
    vim.keymap.set('n', '<leader>rr', builtin.lsp_references, opts)
    vim.keymap.set('n', '<leader>dd', builtin.lsp_definitions, opts)
    vim.keymap.set('n', '<leader>bb', ':Telescope file_browser<CR>', opts)

    function vim.getVisualSelection()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})

      text = string.gsub(text, "\n", "")
      if #text > 0 then
        return text
      else
        return ''
      end
    end

    vim.keymap.set('v', '<leader>ff', function()
      local text = vim.getVisualSelection()
      builtin.current_buffer_fuzzy_find({ default_text = text })
    end, opts)
    vim.keymap.set('v', '<leader>gg', function()
      local text = vim.getVisualSelection()
      builtin.live_grep({ default_text = text })
    end, opts)
  end,
}
