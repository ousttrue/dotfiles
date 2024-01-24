return {
  {
    "vim-denops/denops.vim",
  },
  {
    "vim-skk/denops-skkeleton.vim",
    dependencies = "vim-denops/denops.vim",
    config = require("config.skkeleton").setup,
  },
}
