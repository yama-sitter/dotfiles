-- Execute 'apply' when saving files under the chezmoi directory
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  pattern = { '*.local/share/chezmoi/*' },
  command = [[ !chezmoi apply --source-path "%" ]],
})

