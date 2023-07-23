return {
  {
    'kkharji/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- Allow 2-byte character icons to be displayed
      vim.fn.setcellwidths {
        { 0xf835, 0xf835, 1 },
      }

      require('lspsaga').setup {}

      vim.api.nvim_create_augroup('ShowLineDiagnostics', {})
      vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        group = 'ShowLineDiagnostics',
        pattern = { '*' },
        callback = function()
          require('lspsaga.diagnostic').show_line_diagnostics()
        end,
      })

      local function show_documentation()
        local ft = vim.opt.filetype._value
        if ft == 'vim' or ft == 'help' then
          vim.cmd([[execute 'h ' . expand('<cword>') ]])
        else
          require('lspsaga.hover').render_hover_doc()
        end
      end

      local opts = { noremap = true }
      vim.keymap.set('n', '<leader>s', show_documentation, opts)
    end,
  },
}
