-- Set template files managed by chezmoi to appropriate file type
vim.filetype.add({
  filename = {
    ['.zshrc.tmpl'] = 'zsh',
    ['.gitconfig.tmpl'] = 'gitconfig',
  },
})

