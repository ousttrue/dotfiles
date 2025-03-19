---@class HtmlElement
---@field src string
---@field node TSNode
---@field children HtmlElement[]
local HtmlElement = {}
HtmlElement.__index = HtmlElement

---@param src string
---@param node TSNode
---@return HtmlElement
function HtmlElement.new(src, node)
  local node_type = node:type()
  assert(node_type == "element" or node_type == "document")
  local self = setmetatable({
    src = src,
    node = node,
    children = {},
  }, HtmlElement)
  return self
end

---@param src string
---@param node TSNode
---@param parent HtmlElement?
function HtmlElement.build(src, node, parent)
  local element = HtmlElement.new(src, node)

  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      if child:type() == "element" then
        local child_elment = HtmlElement.build(src, child, element)
        element:add_child(child_elment)
      end
    end
  end

  return element
end

function HtmlElement:add_child(child)
  table.insert(self.children, child)
end

---@param lines string[]
---@param indent string
function HtmlElement:traverse(lines, indent)
  table.insert(lines, ("%s%s"):format(indent, self))
  for i, child in ipairs(self.children) do
    child:traverse(lines, indent .. "  ")
  end
end

function HtmlElement:__tostring()
  for i = 0, self.node:named_child_count() - 1 do
    local child = self.node:named_child(i)
    local tag_name = self:tag_name()
    if tag_name then
      return "<" .. tag_name .. ">"
    end
  end

  return "[" .. self.node:type() .. "]"
end

---@class HtmlElementIterator
---@field stack [HtmlElement, integer][]
local HtmlElementIterator = {}
HtmlElementIterator.__index = HtmlElementIterator

---@param element HtmlElement
---@return HtmlElementIterator
function HtmlElementIterator.new(element)
  local self = setmetatable({
    stack = { { element, 1 } },
  }, HtmlElementIterator)
  return self
end

---@return string?
function HtmlElement:text()
  for i = 0, self.node:named_child_count() - 1 do
    local child = self.node:named_child(i)
    if child and child:type() == "text" then
      return vim.treesitter.get_node_text(child, self.src)
    end
  end
end

---@return string?
function HtmlElement:tag_name()
  for i = 0, self.node:named_child_count() - 1 do
    local child = self.node:named_child(i)
    if child and child:type() == "start_tag" then
      for j = 0, child:named_child_count() - 1 do
        local childchild = child:named_child(j)
        if childchild and childchild:type() == "tag_name" then
          return vim.treesitter.get_node_text(childchild, self.src)
        end
      end
    end
  end
end

---@return HtmlElement?
function HtmlElementIterator:next()
  while #self.stack > 0 do
    local current, index = unpack(self.stack[#self.stack])
    local next_elment = current.children[index]
    if next_elment then
      table.insert(self.stack, { next_elment, 1 })
      return next_elment
    else
      table.remove(self.stack)
      if #self.stack > 0 then
        self.stack[#self.stack][2] = self.stack[#self.stack][2] + 1
      end
    end
  end
end

function HtmlElement:iterator()
  ---@param it HtmlElementIterator
  local function f(it)
    local element = it:next()
    return element
  end
  return f, HtmlElementIterator.new(self)
end

return HtmlElement
