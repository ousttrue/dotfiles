-- Packer.nvim v1
vim.cmd "packadd vim-jetpack"
require("jetpack.packer").startup(function(use)
  use { "tani/vim-jetpack", opt = 1 } -- bootstrap
  use {
    "dracula/vim",
    as = "dracula",
    config = function()
      -- vim.cmd "colorscheme everforest"
      vim.cmd "colorscheme dracula"
    end,
  }
  --
  -- lua minimum
  --
  -- formatter => languageserver
  use { "ckipp01/stylua-nvim" }
  -- comment
  -- git
end)
