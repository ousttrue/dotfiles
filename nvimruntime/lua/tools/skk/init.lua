---
--- https://zenn.dev/uga_rosa/articles/ec5281d5a95a57
--- https://zenn.dev/uga_rosa/articles/e4c532a59de7d6
---
local MODULE_NAME = "tools.skk"
local Context = require "tools.skk.context"

local M = {}

---@class Skk
---@field context Context
local Skk = {}
M.Skk = Skk

---@return Skk
function Skk.new()
  local self = setmetatable({}, {
    __index = Skk,
  })
  self.context = Context.new()

  --
  -- event
  --
  local group = vim.api.nvim_create_augroup(MODULE_NAME, { clear = true })

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
    remap = false,
    expr = true,
  })

  --
  -- reload
  --
  require("tools.reload").autocmd(group, MODULE_NAME, function()
    -- shutdown
    self:delete()
    return nil
  end, function(content)
    -- reload
    require(MODULE_NAME).Skk.new()
  end)

  return self
end

function Skk.delete(self)
  self.context:delete()
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
