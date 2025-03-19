local BLOCK_TAGS = { "h1", "h2", "h3", "h4", "h5", "h6", "p", "div" }

---@param tag_name string?
---@return boolean
local function is_block(tag_name)
  for _, b in ipairs(BLOCK_TAGS) do
    if b == tag_name then
      return true
    end
  end
  return true
end

---@class PushLine
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

---@return boolean
function PushLine:has_block()
  for _, e in ipairs(self.elements) do
    if is_block(e:tag_name()) then
      return true
    end
  end
  return false
end

---@param lines string[]
---@param element HtmlElement?
function PushLine:push_element(lines, element)
  local text
  if element then
    table.insert(self.elements, element)
    text = element:text()
  end

  if text and #text > 0 then
    if self:has_block() and #self.texts > 0 then
      local line = table.concat(self.texts, " ")
      table.insert(lines, line)
      self.texts = {}
      self.elements = {}
    end
    local text = text:gsub("\n", " ")
    table.insert(self.texts, text)
  end

  if #self.texts > 0 then
    local line = table.concat(self.texts, " ")
    table.insert(lines, line)
    self.texts = {}
    self.elements = {}
  end
end

---@param src string
---@param node TSNode
---@return 'document'|'start_tag'|'end_tag'|'text'|nil
---@return string?
local function get_node_type(src, node)
  local node_type = node:type()
  if node_type == "document" then
    return "document"
  elseif node_type == "element" then
    for i = 0, node:named_child_count() - 1 do
      local child = node:named_child(i)
      if child then
        local child_type = child:type()
        if child_type == "start_tag" then
          local text = vim.treesitter.get_node_text(child, src)
          return "start_tag", text
        elseif child_type == "end_tag" then
          return "end_tag"
        end
      end
    end
  elseif node_type == "text" then
    local text = vim.treesitter.get_node_text(node, src)
    return "text", text
  end
end

---@param node TSNode element, text
---@return boolean continue_child
function PushLine:push_node(node)
  assert(node)
  local node_type, text = get_node_type(self.src, node)
  if node_type == "document" then
    return true
  elseif node_type == "start_tag" then
    table.insert(self.lines, text)
    return true
  elseif node_type == "end_tag" then
    --
  elseif node_type == "text" then
    assert(text)
    text = text:gsub("\n", " ")
    table.insert(self.lines, text)
  end

  return false
end

return PushLine
