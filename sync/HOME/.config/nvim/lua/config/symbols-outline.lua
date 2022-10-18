local M = {}

function M.setup()
  require("symbols-outline").setup()
  vim.keymap.set("n", "<Leader>s", ":SymbolsOutline<CR>", { noremap = true })
end

return M
