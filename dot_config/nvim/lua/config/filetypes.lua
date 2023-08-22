-- Set template files managed by chezmoi to appropriate file type
vim.filetype.add({
  pattern = {
    ['.*zshrc.tmpl'] = 'zsh',
    ['.*gitconfig.tmpl'] = 'gitconfig',
    ['*.ejs'] = 'html',
  },
})
