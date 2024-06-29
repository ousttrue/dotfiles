function MY_RUNIME()
  return vim.fn.fnamemodify("~", ":p") .. "/dotfiles/nvimruntime"
end
vim.opt.runtimepath:prepend(MY_RUNIME())
require("_init").setup()
