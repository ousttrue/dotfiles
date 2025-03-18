local M = {}

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

---@param src string
---@param lines string[]
---@param path TSNode[]
local function traverse(src, lines, path)
  local node = path[#path]
  local node_type = node:type()
  print(node_type)
  local text

  if node_type == "tag_name" and path[#path - 1]:type() == "start_tag" then
    print(vim.inspect(path))
    text = ("<%s>%d"):format(vim.treesitter.get_node_text(node, src), get_level(path))
  elseif node_type == "text" then
    text = ("%s#%d"):format(vim.treesitter.get_node_text(node, src), get_level(path))
  end
  if text then
    table.insert(lines, ("%s%s"):format(get_indent(path), text))
  end
  -- for child, _ in node:iter_children() do
  --   traverse(src, lines, push(path, child))
  -- end
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    traverse(src, lines, push(path, child))
  end
end

---@param lines string[]
---@param body string
local function add_lines(lines, body)
  body = [[
<html>
  <body>
    <p>hello</p>
  </body>
</html>
]]
  local parser = vim.treesitter.get_string_parser(body, "html")
  local tree = parser:parse()
  if tree then
    local root = tree[1]:root()
    traverse(body, lines, { root })
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
