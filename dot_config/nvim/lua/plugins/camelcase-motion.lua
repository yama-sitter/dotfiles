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
      vim.keymap.set('n', 'w', '<Plug>CamelCaseMotion_w', options)
      vim.keymap.set('n', 'b', '<Plug>CamelCaseMotion_b', options)
      vim.keymap.set('n', 'e', '<Plug>CamelCaseMotion_e', options)
      vim.keymap.set('n', 'ge', '<Plug>CamelCaseMotion_ge', options)
      vim.keymap.set('v', 'w', '<Plug>CamelCaseMotion_w', options)
      vim.keymap.set('v', 'b', '<Plug>CamelCaseMotion_b', options)
      vim.keymap.set('v', 'e', '<Plug>CamelCaseMotion_e', options)
      vim.keymap.set('v', 'ge', '<Plug>CamelCaseMotion_ge', options)
    end,
  },
}
