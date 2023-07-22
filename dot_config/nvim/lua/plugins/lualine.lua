
return {
  {
    'hoob3rt/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      tabline = {
        lualine_a = { 'buffers' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'diff' },
        lualine_y = { 'branch' },
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
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
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

