local KEYS = vim.split("abcdefghijklmnopqrstuvwxyz", "")

local KanaTable = require "tools.skk.kana.kana_table"
local PreEdit = require "tools.skk.preedit"
local InputState = require("tools.skk.state").InputState

local Input = require "tools.skk.input"

---@class Keymap
local Keymap = {}

local keyMaps = {
  input = setmetatable({}, {
    __index = function()
      return Input.kanaInput
    end,
  }),
  henkan = {},
}

---@param context Context
---@param key string
function Keymap.handleKey(context, key)
  keyMaps[context.state.type][key](context, key)
end

---@class Context
---@field kanaTable KanaTable 全ての変換ルール
---@field preEdit PreEdit
---@field state State
---@field tmpResult? KanaRule feedに完全一致する変換ルール
local Context = {}

---@return Context
function Context.new()
  local self = setmetatable({}, { __index = Context })
  self.kanaTable = KanaTable.new()
  self.preEdit = PreEdit.new()
  self.state = InputState.new()

  return self
end

---@return string
function Context.enable(self)
  if vim.bo.iminsert == 1 then
    return ""
  end

  -- language-mapping
  for _, lhs in ipairs(KEYS) do
    vim.keymap.set("l", lhs, function()
      Keymap.handleKey(self, lhs)
      return self.preEdit:output(self:toString())
    end, {
      buffer = true,
      silent = true,
      expr = true,
    })
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
function Context.disable(self)
  if vim.bo.iminsert ~= 1 then
    return ""
  end

  -- language-mapping
  for _, lhs in ipairs(KEYS) do
    vim.api.nvim_buf_del_keymap(0, "l", lhs)
  end

  -- vim.defer_fn(function()
  local indicator = require "tools.indicator"
  indicator.set "Aa"
  indicator:close()
  -- end, 0)
  vim.cmd [[set iminsert=0]]
  return "<C-^>"
end

---@param candidates? KanaRule[]
function Context:updateTmpResult(candidates)
  candidates = candidates or self.kanaTable:filter(self.state.feed)
  self.tmpResult = nil
  for _, candidate in ipairs(candidates) do
    if candidate.input == self.state.feed then
      self.tmpResult = candidate
      break
    end
  end
end

---@return string
function Context:toString()
  return self.state:toString()
end

return Context
