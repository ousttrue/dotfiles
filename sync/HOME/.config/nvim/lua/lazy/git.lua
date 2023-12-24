return {
  { "tpope/vim-fugitive" },
  { "NeogitOrg/neogit" },
  { "sindrets/diffview.nvim" },
  { "rhysd/git-messenger.vim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns").setup()
    end,
  },
  {
    "niuiic/git-log.nvim",
    dependencies = {
      "niuiic/core.nvim",
    },
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
