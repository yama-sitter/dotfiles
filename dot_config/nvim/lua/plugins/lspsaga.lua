return {
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lspsaga').setup {
        code_action = {
          -- extend_gitsigns = true,
        }
      }

      -- vim.api.nvim_create_augroup('ShowLineDiagnostics', {})
      -- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      --   group = 'ShowLineDiagnostics',
      --   callback = function()
      --     require('lspsaga.diagnostic.show'):show_diagnostics({ line = true })
      --   end,
      -- })

      local function show_documentation()
        local ft = vim.opt.filetype._value
        if ft == 'vim' or ft == 'help' then
          vim.cmd([[execute 'h ' . expand('<cword>') ]])
        else
          require('lspsaga.hover').render_hover_doc()
        end
      end

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>c', show_documentation, opts)
      vim.keymap.set('n', '<leader>d', ':Lspsaga show_line_diagnostics<CR>', opts)
      vim.keymap.set('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
    end,
  },
}
