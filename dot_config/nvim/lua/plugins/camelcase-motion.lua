return {
  {
    'bkad/CamelCaseMotion',
    event = 'VeryLazy',
    dependencies = {
      'kana/vim-smartword',
    },
    config = function()
      vim.g.camelcasemotion_key = '<leader>'

      local options = { silent = true }
      vim.keymap.set('', 'w', '<Plug>CamelCaseMotion_w', options)
      vim.keymap.set('', 'b', '<Plug>CamelCaseMotion_b', options)
      vim.keymap.set('', 'e', '<Plug>CamelCaseMotion_e', options)
      vim.keymap.set('', 'ge', '<Plug>CamelCaseMotion_ge', options)
    end,
  },
}
