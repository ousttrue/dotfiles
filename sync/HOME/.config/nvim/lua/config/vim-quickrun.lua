local M = {}

function M.setup()
  vim.keymap.set("n", "<leader>r", ":QuickRun<CR>", { noremap = true })
end

return M
