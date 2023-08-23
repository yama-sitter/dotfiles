return {
  {
    'hoob3rt/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      'catppuccin/nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        theme = 'catppuccin'
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
          },
        },
        lualine_c = {
          {
            'filename',
            path = 3,
            file_status = true,
            shorting_target = 40,
            symbols = {
              modified = ' [+]',
              readonly = ' [RO]',
              unnamed = 'Untitled',
            },
          },
        },
        lualine_x = { 'filetype', 'encoding' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 3,
            file_status = true,
            shorting_target = 40,
            symbols = {
              modified = ' [+]',
              readonly = ' [RO]',
              unnamed = 'Untitled',
            },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' }
      },
    },
  },
}
