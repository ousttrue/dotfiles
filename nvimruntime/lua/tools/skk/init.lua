---
--- https://zenn.dev/uga_rosa/articles/ec5281d5a95a57
--- https://zenn.dev/uga_rosa/articles/e4c532a59de7d6
---
local M = {}

---@class Skk
---@field context Context
local Skk = {}

---@return Skk
function Skk.new()
  local self = setmetatable({}, {
    __index = Skk,
  })
  self.context = require("tools.skk.context").new()

  --
  -- event
  --
  local group = vim.api.nvim_create_augroup("SkkGroup", { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    pattern = { "*" },
    callback = function(ev)
      self.context:disable()
    end,
  })

  --
  -- keymap
  --
  vim.keymap.set("i", "<C-j>", function()
    return self:toggle()
  end, {
    buffer = true,
    remap = false,
    expr = true,
  })

  M.instance = self
  return self
end

---@return string
function Skk.toggle(self)
  if vim.bo.iminsert == 1 then
    return self.context:disable()
  else
    return self.context:enable()
  end
end

function M.setup()
  Skk.new()
end

return M
