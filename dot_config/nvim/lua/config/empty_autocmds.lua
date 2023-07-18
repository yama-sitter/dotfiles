-- Editing a file managed by chezmoi will execute "apply" command
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = '~/.local/share/chezmoi/*',
  command = 'chezmoi apply --source-path %',
})

