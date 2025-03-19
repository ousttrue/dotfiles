---@type table<string, {prefix:string?, newline:boolean?}>
local BLOCK_PREFIX_MAP = {
  h1 = { prefix = "#", newline = true },
  h2 = { prefix = "##", newline = true },
  h3 = { prefix = "###", newline = true },
  h4 = { prefix = "####", newline = true },
  h5 = { prefix = "#####", newline = true },
  h6 = { prefix = "######", newline = true },
  p = {},
  div = {},
  br = { newline = true },
}

---@class PushLine
---@field lines string[]
---@field src string
---@field texts string[]
---@field elements HtmlElement[]
local PushLine = {}
PushLine.__index = PushLine

---@param lines string[]
---@param src string
---@return PushLine
function PushLine.new(lines, src)
  local self = setmetatable({
    lines = lines,
    src = src,
    texts = {},
    elements = {},
  }, PushLine)
  return self
end

function PushLine:push_text(text)
  assert(type(text) == "string")
  text = text:gsub("%s", " ")
  text = text:match "^%s*(.-)%s*$"
  if #text == 0 then
    return
  end
  table.insert(self.texts, text)
end

---@return boolean
function PushLine:flush_texts()
  local text = table.concat(self.texts, "")
  self.texts = {}

  if text:match "^%s*$" then
    return false
  end

  table.insert(self.lines, text)
  return true
end

function PushLine:newline()
  if #self.lines > 0 and not self.lines[#self.lines]:match "^%s*$" then
    table.insert(self.lines, "")
  end
end

function PushLine:start_tag(text, closing)
  assert(type(text) == "string")
  local tag = text:match "^<(%w+)"
  local block = BLOCK_PREFIX_MAP[tag]
  if block then
    self:flush_texts()
    self:newline()
    if block.prefix and #block.prefix > 0 then
      table.insert(self.texts, block.prefix)
    end
  end
end

function PushLine:end_tag(text)
  assert(type(text) == "string")
  local tag = text:match "^<(%w+)"
  local block = BLOCK_PREFIX_MAP[tag]
  if block then
    self:flush_texts()
    if block.newline then
      self:newline()
    end
  end
end

return PushLine
