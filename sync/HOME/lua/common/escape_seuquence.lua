local M = {}

local VARS = require "common.vars"

---@param fmt string
---@param ... ...
---@return string
function M.format(fmt, ...)
  return string.format(
    string.gsub(fmt, "<(%w+)>", function(m)
      -- print(m)
      return "\027[" .. VARS.fg[m] .. "m"
    end),
    ...
  )
end

return M
