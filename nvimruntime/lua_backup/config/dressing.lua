local M = {}
function M.setup()
  local dot = require "dot"
  require("dressing").setup {
    input = {
      border = dot.border,
    },
    nui = {
      border = dot.border,
    },
    builtin = {
      border = dot.border,
    },
  }
end
return M
