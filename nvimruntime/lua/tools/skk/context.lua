--
-- vim に関わらない状態
--
local utf8 = require "utf8"

local KanaTable = require("tools.skk.kana_table").rules

local function string_startswith(self, start)
  return self:sub(1, #start) == start
end

---inputとの前方一致で絞り込む
---@param pre string
---@return KanaRule[]
local function filter(pre)
  local items = {}
  for i, item in ipairs(KanaTable) do
    if string_startswith(item.input, pre) then
      table.insert(items, item)
    end
  end
  return items
end

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
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

  return self
end

function Context.delete(self) end

-- https://zenn.dev/uga_rosa/articles/e4c532a59de7d6
---@param char string
---@return string
function Context.kanaInput(self, char)
  local input = self.feed .. char
  local candidates = filter(input)
  print(dump(candidates))
  if #candidates == 1 and candidates[1].input == input then
    -- 候補が一つかつ完全一致。確定
    -- self:acceptResult(candidates[1])
    self.kakutei = self.kakutei .. candidates[1].output
    self.feed = candidates[1].next
    -- self:updateTmpResult()
    candidates = candidates or filter(self.feed)
    self.tmpResult = nil
    for _, candidate in ipairs(candidates) do
      if candidate.input == self.feed then
        self.tmpResult = candidate
        break
      end
    end
  elseif #candidates > 0 then
    -- 未確定
    self.feed = input
    -- self:updateTmpResult(candidates)
    candidates = candidates or filter(self.feed)
    self.tmpResult = nil
    for _, candidate in ipairs(candidates) do
      if candidate.input == self.feed then
        self.tmpResult = candidate
        break
      end
    end
  elseif self.tmpResult then
    -- 新しい入力によりtmpResultで確定
    -- self:acceptResult(self.tmpResult)
    self.kakutei = self.kakutei .. self.tmpResult.output
    self.feed = self.tmpResult.next
    -- self:updateTmpResult()
    candidates = candidates or filter(self.feed)
    self.tmpResult = nil
    for _, candidate in ipairs(candidates) do
      if candidate.input == self.feed then
        self.tmpResult = candidate
        break
      end
    end
    self:kanaInput(char)
  else
    -- 入力ミス。context.tmpResultは既にnil
    self.feed = ""
    self:kanaInput(char)
  end

  return self:preedit(self.feed)
end

---@param next string
---@return string
function Context:preedit(next)
  local ret
  if self.kakutei == "" and string_startswith(next, self.current) then
    ret = next:sub(#self.current)
  else
    local current_len = utf8.len(self.current) or 0 --[[@as integer]]
    ret = string.rep("\b", current_len) .. self.kakutei .. next
  end
  self.current = next
  self.kakutei = ""
  return ret
end

return Context
