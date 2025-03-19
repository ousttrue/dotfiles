local M = {}
local ts_util = require "ts_util"

---@param node TSNode
---@param callback fun(node: TSNode):boolean
local function traverse(node, callback)
  if callback(node) then
    for i = 0, node:named_child_count() - 1 do
      local child = node:named_child(i)
      if child then
        traverse(child, callback)
      end
    end
  end
end

---@param lines string[]
---@param node TSNode
local function get_text(src, lines, node)
  if node:type() == "text" then
    local text = vim.treesitter.get_node_text(node, src)
    if #text > 0 then
      text = text:gsub("\n", " ")
      table.insert(lines, text)
    end
  end

  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      get_text(src, lines, child)
    end
  end
end

---@param src string
---@param node TSNode
---@return string?
local function make_link(src, node)
  assert(node:type() == "element")
  local url
  local texts = {}
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      local child_type = child:type()
      if child_type == "start_tag" then
        local a_text = vim.treesitter.get_node_text(child, src)
        url = a_text:match "%shref%s*=%s*(%S+)"
        url = url:gsub("&amp;", "&")
        local m = url:match '^"([^"]*)">?$'
        if m then
          url = m
        end
      else
        get_text(src, texts, child)
      end
    end
  end

  local url2 = url:match "^/url%?q=([^&]*)"
  -- print(url2, url)
  if url2 then
    local title = table.concat(texts, " ")
    assert(#title > 0)
    -- if #title == 0 then
    --   title = "notext"
    -- end
    return ("[%s](%s)"):format(title, vim.uri_decode(url2))
  else
  end
end

---@param lines string[]
---@param body string
local function add_lines(lines, body)
  local parser = vim.treesitter.get_string_parser(body, "html")
  local tree = parser:parse()
  if tree then
    -- local PushLine = require "PushLine"
    -- local push_line = PushLine.new(lines, body)

    local root = tree[1]:root()
    traverse(root, function(node)
      if node:type() == "document" then
        return true
      end

      local tag = ts_util.html_get_tag_from_element(body, node)
      if tag then
        if tag:match "^<a%s" then
          local link = make_link(body, node)
          if link then
            table.insert(lines, link)
          end
        else
          return true
        end
      elseif node:type() == "text" then
        local text = vim.treesitter.get_node_text(node, body)
        text = text:gsub("\n", " ")
        table.insert(lines, text)
      end

      return false
    end)

    -- local document = HtmlElement.build(body, root)
    -- local push_line = PushLine.new()
    -- for current in document:iterator() do
    --   push_line:push_element(lines, current)
    -- end
    -- push_line:push_element(lines)
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
  -- do
  --   local fd = vim.uv.fs_open("tmp.html", "w", tonumber("666", 8))
  --   if fd then
  --     vim.uv.fs_write(fd, res)
  --     vim.uv.fs_close(fd)
  --   end
  -- end

  local status, header, body = res:match "^(HTTP.-)\r\n(.-)\r\n\r\n(.*)"
  ---@type string[]
  local lines = {}
  local map = add_http_header(lines, status, header)
  if map["Content-Type"] == "text/html; charset=Shift_JIS" then
    body = vim.iconv(body, "shift_jis", "utf-8", {})
  end

  -- main
  -- body = [[
  -- <html>
  --   <body>
  --     <p>hello</p>
  --   </body>
  -- </html>
  -- ]]
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
