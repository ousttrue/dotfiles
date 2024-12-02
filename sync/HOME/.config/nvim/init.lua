function MY_RUNIME()
  return vim.fs.joinpath(vim.fn.fnamemodify("~", ":p"), "dotfiles", "nvimruntime")
end

-- vim.opt.runtimepath:prepend(MY_RUNIME())
vim.opt.runtimepath:prepend "~/dotfiles/nvimruntime"
require("_init").setup()
