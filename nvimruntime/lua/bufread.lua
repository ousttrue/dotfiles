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

---@param lines string[]
---@param body string
local function add_lines(lines, body)
--   body = [[
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
    traverse(lines, TSNodePath.new(body, root))
  end
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
      -- print(string.format("event fired: %s", vim.inspect(ev)))
      local dl_job = vim.system({ "curl", "-Li", ev.file }, { text = false }):wait()
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
