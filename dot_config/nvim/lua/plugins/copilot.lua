return {
  'github/copilot.vim',
  lazy = false,
  config = function()
    -- Disable tab mapping
    -- vim.g.copilot_no_tab_map = true

    vim.keymap.set('i', '<C-g>', 'copilot#Accept("<CR>")',
      { silent = true, expr = true, script = true, replace_keycodes = false })

    local opts = { noremap = true, silent = true }
    vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', opts)
    vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', opts)
    vim.keymap.set('i', '<C-o>', '<Plug>(copilot-dismiss)', opts)
    vim.keymap.set('i', '<C-s>', '<Plug>(copilot-suggest)', opts)
  end
}
