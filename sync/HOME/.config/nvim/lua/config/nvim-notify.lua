local M = {}

function M.setup()
  local dot = require "dot"
  require("notify").setup {
    border = dot.border,
    top_down = false,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { border = dot.border })
    end,
  }
end

return M
