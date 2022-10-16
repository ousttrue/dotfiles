local M = {}

function M.setup()
  require("scrollbar").setup()
  require("scrollbar.handlers.search").setup()
end

return M
