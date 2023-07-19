return {
  {
    'shaunsingh/nord.nvim',
    lazy      = false,
    priority  = 1000,
    config    = function()
      vim.cmd[[colorscheme nord]]

      vim.g.nord_disable_background = true
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false

      require('nord').set()
    end,
  }
}
