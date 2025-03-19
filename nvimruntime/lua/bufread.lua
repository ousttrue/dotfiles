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

---@class PushLine
---@field texts string[]
---@field elements HtmlElement[]
local PushLine = {}
PushLine.__index = PushLine

---@return PushLine
function PushLine.new()
  local self = setmetatable({
    texts = {},
    elements = {},
  }, PushLine)
  return self
end

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
    local document = HtmlElement.build(body, root)

    local push_line = PushLine.new()
    for current in document:iterator() do
      push_line:push_element(lines, current)
    end
    push_line:push_element(lines)
  end
end

---@alias MsgMap table<string, string>

---@param lines string[]
---@param status string
---@param header string
---@return MsgMap
local function add_http_header(lines, status, header)
  ---@type MsgMap
  local map = {}
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
    map[k] = v
  end
  table.insert(lines, "}")
  table.insert(lines, "---")
  return map
end

---@param ev vim.api.keyset.create_autocmd.callback_args
local function on_bufreadcmd(ev)
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

  -- debug
  do
    local fd = vim.uv.fs_open("tmp.html", "w", tonumber("666", 8))
    if fd then
      vim.uv.fs_write(fd, res)
      vim.uv.fs_close(fd)
    end
  end

  local status, header, body = res:match "^(HTTP.-)\r\n(.-)\r\n\r\n(.*)"
  ---@type string[]
  local lines = {}
  local map = add_http_header(lines, status, header)
  -- print(vim.inspect(map))
  if map["Content-Type"] == "text/html; charset=Shift_JIS" then
    body = vim.iconv(body, "shift_jis", "utf-8", {})
  end
  add_lines(lines, body)
  vim.api.nvim_buf_set_lines(ev.buf, -2, -1, true, lines)
  -- vim.api.nvim_buf_set_lines(ev.buf, -2, -1, true, vim.split(body, "\n"))
  vim.api.nvim_set_option_value("modifiable", false, { buf = ev.buf })
end

function M.setup()
  vim.api.nvim_create_autocmd("BufReadCmd", {
    pattern = { "http://*", "https://*" },
    callback = on_bufreadcmd,
  })

  vim.api.nvim_create_user_command("Q", function(ev)
    local url = ("https://www.google.com/search?hl=ja&ie=UTF-8&q=%s"):format(vim.uri_encode(ev.fargs[1]))
    print(url)
    -- vim.cmd(("edit %s"):format(url))
    local w = vim.api.nvim_get_current_win()
    local b = vim.fn.bufadd(url)
    vim.api.nvim_win_set_buf(w, b)
  end, {
    nargs = 1,
  })
end

return M
