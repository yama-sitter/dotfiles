-- Execute 'apply' when saving files under the chezmoi directory
vim.api.nvim_create_augroup('ChezmoiApply', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = 'ChezmoiApply',
  pattern = { '*.local/share/chezmoi/*' },
  command = [[ !chezmoi apply --source-path "%" ]],
})

