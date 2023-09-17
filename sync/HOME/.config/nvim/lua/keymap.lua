local M = {}

function M.setup()
  -- vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true, silent = true })
  vim.keymap.set("n", "j", "gj", { noremap = true })
  vim.keymap.set("n", "k", "gk", { noremap = true })
  vim.keymap.set("n", "gj", "j", { noremap = true })
  vim.keymap.set("n", "gk", "k", { noremap = true })
end

return M
