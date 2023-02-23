local M = {}

function M.setup()
  local dot = require "dot"
  require("notify").setup {
    border = dot.border,
    top_down = false,
  }
end

return M
