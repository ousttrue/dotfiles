local M = {}

function M.setup()
  vim.keymap.set("n", "gm", ":GitMessenger<CR>", { noremap = true })
end

return M
