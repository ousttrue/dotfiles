vim.keymap.set("n", "F", "<cmd>Neoformat python black<CR>",
  { buffer = 0, noremap = true, silent = true })
vim.keymap.set("x", "F", "<cmd>Neoformat! python black<CR>",
  { buffer = 0, noremap = true, silent = true })
