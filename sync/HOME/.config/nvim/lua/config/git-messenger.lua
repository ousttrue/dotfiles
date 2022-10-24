local M = {}

function M.setup()
  vim.keymap.set("n", "<Leader>m", ":GitMessenger<CR>", { noremap = true })
end

return M
