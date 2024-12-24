local utf8 = require "utf8"
local KEYS = vim.split("abcdefghijklmnopqrstuvwxyz", "")

local KanaTable = require("tools.skk.kana_table").rules

---inputとの前方一致で絞り込む
---@param pre string
---@return KanaRule[]
local function filter(pre)
  return vim.tbl_filter(function(rule)
    return vim.startswith(rule.input, pre)
  end, KanaTable)
end

---@class Context
---@field feed string
---@field current string
---@field kakutei string
---@field tmpResult? KanaRule feedに完全一致する変換ルール
local Context = {}

---@return Context
function Context.new()
  local self = setmetatable({}, { __index = Context })
  self.feed = ""
  self.current = ""
  self.kakutei = ""

  self:map()

  return self
end

function Context.delete(self)
  self:unmap()
end

--- language-mapping
function Context.map(self)
  for _, lhs in ipairs(KEYS) do
    vim.keymap.set("l", lhs, function()
      self:kanaInput(lhs)
      return self:preedit(self.feed)
    end, {
      -- buffer = true,
      silent = true,
      expr = true,
    })
  end
end

function Context.unmap(self)
  -- language-mapping
  for _, lhs in ipairs(KEYS) do
    -- vim.api.nvim_buf_del_keymap(0, "l", lhs)
    vim.api.nvim_del_keymap("l", lhs)
  end
end

---@param next string
---@return string
function Context:preedit(next)
  local ret
  if self.kakutei == "" and vim.startswith(next, self.current) then
    ret = next:sub(#self.current)
  else
    local current_len = utf8.len(self.current) or 0 --[[@as integer]]
    ret = string.rep("\b", current_len) .. self.kakutei .. next
  end
  self.current = next
  self.kakutei = ""
  return ret
end

---@param result KanaRule
function Context.acceptResult(self, result)
  self.kakutei = self.kakutei .. result.output
  self.feed = result.next
end

---@param candidates? KanaRule[]
function Context:updateTmpResult(candidates)
  candidates = candidates or filter(self.feed)
  self.tmpResult = nil
  for _, candidate in ipairs(candidates) do
    if candidate.input == self.feed then
      self.tmpResult = candidate
      break
    end
  end
end

---@param char string
function Context.kanaInput(self, char)
  local input = self.feed .. char
  local candidates = filter(input)
  if #candidates == 1 and candidates[1].input == input then
    -- 候補が一つかつ完全一致。確定
    self:acceptResult(candidates[1])
    self:updateTmpResult()
  elseif #candidates > 0 then
    -- 未確定
    self.feed = input
    self:updateTmpResult(candidates)
  elseif self.tmpResult then
    -- 新しい入力によりtmpResultで確定
    self:acceptResult(self.tmpResult)
    self:updateTmpResult()
    self:kanaInput(char)
  else
    -- 入力ミス。context.tmpResultは既にnil
    self.feed = ""
    self:kanaInput(char)
  end
end

---@return string
function Context.enable(self)
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
function Context.disable(self)
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

return Context
