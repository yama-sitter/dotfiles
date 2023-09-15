return {
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lspsaga').setup {}

      -- vim.api.nvim_create_augroup('ShowLineDiagnostics', {})
      -- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
      --   group = 'ShowLineDiagnostics',
      --   callback = function()
      --     require('lspsaga.diagnostic.show'):show_diagnostics({ line = true })
      --   end,
      -- })

      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', 'K', ':Lspsaga hover_doc<CR>', opts)
      vim.keymap.set('n', 'J', ':Lspsaga show_line_diagnostics<CR>', opts)
      vim.keymap.set('n', '<leader>ca', ':Lspsaga code_action<CR>', opts)
      vim.keymap.set('n', '<C-k>', ':Lspsaga diagnostic_jump_prev<CR>', opts)
      vim.keymap.set('n', '<C-j>', ':Lspsaga diagnostic_jump_next<CR>', opts)
    end,
  },
}
