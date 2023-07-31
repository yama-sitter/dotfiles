return {
  {
    'kkharji/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('lspsaga').setup {}

      vim.api.nvim_create_augroup('ShowLineDiagnostics', {})
      vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        group = 'ShowLineDiagnostics',
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

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>s', show_documentation, opts)
      vim.keymap.set('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
    end,
  },
}
