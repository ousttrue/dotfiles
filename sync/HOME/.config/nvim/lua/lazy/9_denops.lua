return {
  {
    "vim-skk/denops-skkeleton.vim",
    dependencies = "vim-denops/denops.vim",
    config = require("config.skkeleton").setup,
  },
  {
    "lambdalisue/kensaku.vim",
    dependencies = "vim-denops/denops.vim",
  },
}
