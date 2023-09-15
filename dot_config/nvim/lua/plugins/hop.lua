return {
  {
    'phaazon/hop.nvim',
    event = 'VeryLazy',
    config = function()
      require 'hop'.setup {}

      local options = { noremap = true }
      vim.keymap.set('', '<leader>jj', ':HopWord<CR>', options)
    end,
  },
}
