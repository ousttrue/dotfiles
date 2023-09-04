local M = {}

---@class Section
---@field Fg string
---@field Bg string
---@field Text string

---@class PowerLine
---@field list Section[]
local PowerLineClass = {
  ---@param self PowerLine
  ---@param section Section
  ---@return PowerLine
  push = function(self, section)
    if section.Fg then
      table.insert(self.list, { Foreground = { Color = section.Fg } })
    end
    if section.Bg then
      table.insert(self.list, { Background = { Color = section.Bg } })
    end
    if section.Text then
      table.insert(self.list, { Text = section.Text })
    end
    return self
  end,
}

---@return PowerLine Section[]
function M.PowerLine()
  local instance = {
    list = {},
  }
  setmetatable(instance, { __index = PowerLineClass })
  return instance
end

return M
