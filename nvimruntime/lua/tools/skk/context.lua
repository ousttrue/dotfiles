local utf8 = require "utf8"
local KEYS = vim.split("abcdefghijklmnopqrstuvwxyz", "")
local KanaTable = require "tools.skk.kana_table"

---バッファの変化から差分を生成する
---@class PreEdit
local PreEdit = {}

---@return PreEdit
function PreEdit.new()
  return setmetatable({
    current = "",
    kakutei = "",
  }, { __index = PreEdit })
end

---@param str string
function PreEdit:doKakutei(str)
  self.kakutei = self.kakutei .. str
end

---@param next string
---@return string
function PreEdit:output(next)
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

---@class Context
---@field kanaTable KanaTable 全ての変換ルール
---@field preEdit PreEdit
---@field type string
---@field feed string
---@field mode string
---@field current string
---@field kakutei string
---@field tmpResult? KanaRule feedに完全一致する変換ルール
local Context = {}

---@return Context
function Context.new()
  local self = setmetatable({}, { __index = Context })
  self.kanaTable = KanaTable.new()
  self.preEdit = PreEdit.new()
  self.type = "input"
  self.mode = "direct"
  self.feed = ""
  return self
end

---@param result KanaRule
function Context.acceptResult(self, result)
  local preEdit = self.preEdit
  local kana, feed = result.output, result.next
  preEdit:doKakutei(kana)
  self.feed = feed
end

---@param char string
function Context.kanaInput(self, char)
  local input = self.feed .. char
  local candidates = self.kanaTable:filter(input)
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

  -- language-mapping
  for _, lhs in ipairs(KEYS) do
    vim.keymap.set("l", lhs, function()
      self:kanaInput(lhs)
      return self.preEdit:output(self.feed)
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
  candidates = candidates or self.kanaTable:filter(self.feed)
  self.tmpResult = nil
  for _, candidate in ipairs(candidates) do
    if candidate.input == self.feed then
      self.tmpResult = candidate
      break
    end
  end
end

return Context
