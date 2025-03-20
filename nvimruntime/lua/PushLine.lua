---@type table<string, {prefix:string?, start_newline: boolean?, end_newline:boolean?}>
local BLOCK_PREFIX_MAP = {
  title = { prefix = "# ", start_newline = true, end_newline = true },
  h1 = { prefix = "# ", start_newline = true, end_newline = true },
  h2 = { prefix = "## ", start_newline = true, end_newline = true },
  h3 = { prefix = "### ", start_newline = true, end_newline = true },
  h4 = { prefix = "#### ", start_newline = true, end_newline = true },
  h5 = { prefix = "##### ", start_newline = true, end_newline = true },
  h6 = { prefix = "###### ", start_newline = true, end_newline = true },
  p = {},
  div = {},
  tr = {},
  thead = {},
  table = {},
  tbody = {},
  br = { end_newline = true },
  from = {},
  ul = {},
  ol = {},
  li = { prefix = "- " },
  article = { end_newline = true },
  hr = { prefix = "---", end_newline = true },
}

local INLINE_PREFIX_MAP = {
  td = { prefix = "|" },
  th = { prefix = "|" },
  html = {},
  head = {},
  meta = {},
  body = {},
  header = {},
  link = {},
  noscript = {},
  img = {},
  span = {},
  input = {},
  button = {},
  nav = {},
  main = {},
  section = {},
  aside = {},
  footer = {},
  cite = {},
  time = { prefix = " `", suffix = "` " },
  code = { prefix = " `", suffix = "` " },
  strong = { prefix = " `", suffix = "` " },
  small = { prefix = " `", suffix = "` " },
  b = { prefix = " `", suffix = "` " },
  figcaption = { prefix = " `", suffix = "` " },
  address = {},
  template = {},
  i = {},
  u = {},
  font = {},
  center = {},
  ins = {},
  figure = {},
  label = {},
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

function PushLine:push_line(text)
  assert(type(text) == "string")
  self:flush_texts()
  table.insert(self.lines, text)
end

---@return boolean
function PushLine:flush_texts()
  if self.texts[#self.texts] == "- " then
    table.remove(self.texts)
  end
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
  assert(tag)
  tag = tag:lower()
  local block = BLOCK_PREFIX_MAP[tag]
  local inline = INLINE_PREFIX_MAP[tag]

  if block then
    self:flush_texts()
    if block.start_newline then
      self:newline()
    end
    if block.prefix and #block.prefix > 0 then
      table.insert(self.texts, block.prefix)
    end
  elseif inline then
    if inline.prefix and #inline.prefix > 0 then
      table.insert(self.texts, inline.prefix)
    end
  else
    if closing then
      table.insert(self.texts, "<" .. tag .. "/>")
    else
      table.insert(self.texts, "<" .. tag .. ">")
    end
  end
end

function PushLine:end_tag(text)
  assert(type(text) == "string")
  local tag = text:match "^<(%w+)"
  assert(tag)
  tag = tag:lower()
  local block = BLOCK_PREFIX_MAP[tag]
  local inline = INLINE_PREFIX_MAP[tag]
  if block then
    self:flush_texts()
    if block.end_newline then
      self:newline()
    end
  elseif inline then
    if inline.suffix and #inline.suffix > 0 then
      table.insert(self.texts, inline.suffix)
    end
  else
    table.insert(self.texts, "</" .. tag .. ">")
  end
end

return PushLine
