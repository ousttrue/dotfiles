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
}
