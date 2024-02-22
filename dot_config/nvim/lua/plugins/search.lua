return {
  {
    -- Highlight annotations like TODO, FIXME, etc.
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("todo-comments").setup()

      vim.keymap.set(
        "n",
        "<leader>tt",
        ":TodoTelescope keywords=TODO theme=ivy path_display={'smart'}<CR>",
        { noremap = true, desc = "Search for TODOs" }
      )
    end,
  },
}
