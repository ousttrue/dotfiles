return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("config.telescope").setup()
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
}
