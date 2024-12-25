---
--- vim の状態管理
---
--- https://zenn.dev/uga_rosa/articles/ec5281d5a95a57
--- https://zenn.dev/uga_rosa/articles/e4c532a59de7d6
---
local MODULE_NAME = "tools.skk"
local Context = require "tools.skk.context"
local KEYS = vim.split("abcdefghijklmnopqrstuvwxyz", "")

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
  self:map()

  --
  -- event
  --
  local group = vim.api.nvim_create_augroup(MODULE_NAME, { clear = true })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = group,
    pattern = { "*" },
    callback = function(ev)
      self:disable()
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
  self:unmap()
  self.context:delete()
end

--- language-mapping
function Skk.map(self)
  for _, lhs in ipairs(KEYS) do
    vim.keymap.set("l", lhs, function()
      return self.context:kanaInput(lhs)
    end, {
      -- buffer = true,
      silent = true,
      expr = true,
    })
  end
end

function Skk.unmap(self)
  -- language-mapping
  for _, lhs in ipairs(KEYS) do
    -- vim.api.nvim_buf_del_keymap(0, "l", lhs)
    vim.api.nvim_del_keymap("l", lhs)
  end
end

---@return string
function Skk.enable(self)
  if vim.bo.iminsert == 1 then
    return ""
  end

  -- vim.defer_fn(function()
  local indicator = require "tools.indicator"
  indicator:open()
  indicator.set "あ"
  -- end, 0)
  vim.cmd [[set iminsert=1]]
  return "<C-^>"
end

---@return string
function Skk.disable(self)
  if vim.bo.iminsert ~= 1 then
    return ""
  end

  -- vim.defer_fn(function()
  local indicator = require "tools.indicator"
  indicator.set "Aa"
  indicator:close()
  -- end, 0)
  vim.cmd [[set iminsert=0]]
  return "<C-^>"
end


---@return string
function Skk.toggle(self)
  if vim.bo.iminsert == 1 then
    return self:disable()
  else
    return self:enable()
  end
end

function M.setup()
  Skk.new()
end

return M
