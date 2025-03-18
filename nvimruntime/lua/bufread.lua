local M = {}

---@class TSNodePath
---@field src string
---@field nodes TSNode[]
local TSNodePath = {}
TSNodePath.__index = TSNodePath

---@param ... TSNode[]
---@return TSNodePath
function TSNodePath.new(src, ...)
  local self = setmetatable({
    src = src,
    nodes = { ... },
  }, TSNodePath)
  return self
end

---@return string
function TSNodePath:__tostring()
  local str
  for i, node in ipairs(self.nodes) do
    if str then
      str = str .. "/" .. node:type()
    else
      str = node:type()
    end

    if i == #self.nodes then
      if node:type() ~= "document" and node:type() ~= "element" then
        str = str .. " => " .. vim.treesitter.get_node_text(node, self.src):gsub("\n", "<br>")
      end
    end
  end
  return str
end

---@param node TSNode
---@return TSNodePath
function TSNodePath:push(node)
  local list = { unpack(self.nodes) }
  table.insert(list, node)
  return TSNodePath.new(self.src, unpack(list))
end

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
    if child and child:type() == "start_tag" then
      for j = 0, self.node:named_child_count() - 1 do
        local childchild = child:named_child(j)
        if childchild and childchild:type() == "tag_name" then
          return vim.treesitter.get_node_text(child, self.src):gsub("\n", " ")
        end
      end
    end
  end

  return "<no_tag>"
end

local function push(path, node)
  local list = {}
  for _, p in ipairs(path) do
    table.insert(list, p)
  end
  table.insert(list, node)
  return list
end

local function get_level(path)
  local level = 0
  for _, node in ipairs(path) do
    if node:type() == "<" then
      level = level + 1
    end
  end
  return level
end

local function get_indent(path)
  local indent = ""
  for i = 1, get_level(path) do
    indent = indent .. "  "
  end
  return indent
end

---@param lines string[]
---@param path TSNodePath
local function traverse(lines, path)
  local node = path.nodes[#path.nodes]
  table.insert(lines, tostring(path))
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      traverse(lines, path:push(child))
    end
  end
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

---@param lines string[]
---@param body string
local function add_lines(lines, body)
  -- body = [[
  -- <html>
  --   <body>
  --     <p>hello</p>
  --   </body>
  -- </html>
  -- ]]
  local parser = vim.treesitter.get_string_parser(body, "html")
  local tree = parser:parse()
  if tree then
    local root = tree[1]:root()
    -- traverse(lines, TSNodePath.new(body, root))
    local element = HtmlElement.build(body, root)
    -- element:traverse(lines, "")
    for current in element:iterator() do
      local text = current:text()
      if text then
        for _, l in ipairs(vim.split(text, "\n")) do
          table.insert(lines, l)
        end
      end
    end
  end

  -- for _, l in ipairs(vim.split(body, "\n")) do
  --   table.insert(lines, l)
  -- end
end

---@param lines string[]
---@param status string
---@param header string
local function add_http_header(lines, status, header)
  for _, line in ipairs {
    "---",
    "# vim: ft=markdown",
    '"status": "' .. status .. '"',
    '"http-header": {',
  } do
    table.insert(lines, line)
  end
  for k, v in header:gmatch "([^:]+):%s*(.-)\r\n" do
    table.insert(lines, '  "' .. k .. '": "' .. v .. '"')
  end
  table.insert(lines, "}")
  table.insert(lines, "---")
end

function M.setup()
  vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = { "http://*", "https://*" },
    callback = function(ev)
      vim.api.nvim_set_option_value("modifiable", true, { buf = ev.buf })

      -- print(string.format("event fired: %s", vim.inspect(ev)))
      local dl_job = vim
        .system({
          "curl",
          "-0",
          "-L",
          "-i",
          "-H",
          "USER-AGENT: w3m/0.5.3+git20230121",
          ev.file,
        }, { text = false })
        :wait()
      -- vim.notify_once(("get %dbytes"):format(#dl_job.stdout), vim.log.levels.INFO, { title = ev.file })
      local res = dl_job.stdout
      assert(res)
      local status, header, body = res:match "^(HTTP.-)\r\n(.-)\r\n\r\n(.*)"
      ---@type string[]
      local lines = {}
      add_http_header(lines, status, header)
      add_lines(lines, body)
      vim.api.nvim_buf_set_lines(ev.buf, -2, -1, true, lines)
      -- vim.api.nvim_buf_set_lines(ev.buf, -2, -1, true, vim.split(body, "\n"))
      vim.api.nvim_set_option_value("modifiable", false, { buf = ev.buf })
    end,
  })
end

return M
