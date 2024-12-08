local input = require("tools.iim.input")

local M = {}

---@param context Context
---@param keys string
function M.dispatch(context, keys)
  for key in vim.gsplit(keys, "") do
    input.kanaInput(context, key)
  end
end

return M
