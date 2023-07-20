-- Execute 'apply' when saving files under the chezmoi directory
vim.api.nvim_create_augroup('ChezmoiApply', {})
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = 'ChezmoiApply',
  pattern = { '*.local/share/chezmoi/*' },
  command = [[ !chezmoi apply --source-path "%" ]],
})

-- Close a quickfix window along with a buffer
vim.api.nvim_create_augroup('AutoCloseQf', {})
vim.api.nvim_create_autocmd({ 'WinEnter' }, {
  group = 'AutoCloseQf',
  command = [[ if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif ]],
})

