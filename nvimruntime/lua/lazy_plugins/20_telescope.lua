return {
  {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    dependencies = {
      "danielfalk/smart-open.nvim",
      "nvim-lua/plenary.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- ex
      "nvim-telescope/telescope-frecency.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "atusy/qfscope.nvim",
    },
    config = function()
      require('config.telescope').setup()
    end,
  },
}
