return {
  -- {
  --   "NeogitOrg/neogit",
  --   branch = "nightly",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- required
  --     "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --     -- Only one of these is needed, not both.
  --     "nvim-telescope/telescope.nvim", -- optional
  --     -- "ibhagwan/fzf-lua", -- optional
  --   },
  --   config = function()
  --     local neogit = require "neogit"
  --     neogit.setup {}
  --   end,
  -- },
  -- { "sindrets/diffview.nvim" },
  { "rhysd/git-messenger.vim" },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   config = function()
  --     require("config.gitsigns").setup()
  --   end,
  -- },
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
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup()
      vim.keymap.set("n", "co", "<Plug>(git-conflict-ours)")
      vim.keymap.set("n", "ct", "<Plug>(git-conflict-theirs)")
      vim.keymap.set("n", "cb", "<Plug>(git-conflict-both)")
      vim.keymap.set("n", "c0", "<Plug>(git-conflict-none)")
      vim.keymap.set("n", "]x", "<Plug>(git-conflict-prev-conflict)")
      vim.keymap.set("n", "[x", "<Plug>(git-conflict-next-conflict)")
    end,
  },
}
