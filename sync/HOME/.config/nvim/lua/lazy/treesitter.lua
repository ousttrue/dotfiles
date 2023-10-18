return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- run = function()
    --   require("nvim-treesitter.install").update { with_sync = true }
    -- end,
    config = require("config.nvim-treesitter").setup,
    dependencies = "nvim-treesitter/playground",
  },
  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "kevinhwang91/promise-async",
  --   },
  --   config = function()
  --     require("config.nvim-ufo").setup()
  --   end,
  -- },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial").setup()
    end,
  },
  {
    "andymass/vim-matchup",
    config = function()
      -- vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
}
