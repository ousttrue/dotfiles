local M = {}

---@param lines string[]
---@param node TSNode
---@param field string
local function traverse(lines, node, field, indent)
  table.insert(lines, ("%s%s"):format(indent, node:type()))
  for child, child_field in node:iter_children() do
    traverse(lines, child, child_field, indent .. "  ")
  end
end

---@param lines string[]
---@param body string
local function add_lines(lines, body)
  local parser = vim.treesitter.get_string_parser(body, "html")
  local tree = parser:parse()
  if tree then
    local root = tree[1]:root()
    traverse(lines, root, "__root__", "")
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
