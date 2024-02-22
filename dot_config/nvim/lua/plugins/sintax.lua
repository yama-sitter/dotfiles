return {
  {
    -- Highlight the current word under the cursor
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("illuminate").configure()
    end,
  },
}
