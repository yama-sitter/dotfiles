return {
  'David-Kunz/jester',
  ft = {
    'typescript',
    'typescriptreact',
    'javascript',
    'javacriptreact',
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('jester').setup({
      path_to_jest_run = 'npx jest',
      terminal_cmd = ':split | terminal',
    })

    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '<leader>ja', ':lua require"jester".run_file()<CR>', opts)
    vim.keymap.set('n', '<leader>js', ':lua require"jester".run()<CR>', opts)
  end
}
