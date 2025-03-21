local M = {}
local text_util = require "text_util"

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

---@param src string
---@param node TSNode
---@return string?
local function make_link(src, node)
  assert(node:type() == "element")
  local url
  local text = ""
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      local child_type = child:type()
      if child_type == "start_tag" then
        local a_text = vim.treesitter.get_node_text(child, src)
        url = a_text:match "%shref%s*=%s*(%S+)"
        if not url then
          url = a_text:match "%sHREF%s*=%s*(%S+)"
        end
        if url then
          url = url:gsub("&amp;", "&")
          local m = url:match '^"([^"]*)">?$'
          if m then
            url = m
          end
        else
          -- print("no href", a_text)
        end
      else
        text = text .. text_util.get_text(src, child)
      end
    end
  end

  if url then
    local g_redirect = url:match "^/url%?q=([^&]*)"
    if g_redirect then
      url = g_redirect
    end

    local title = text_util.decode_entity(text:gsub("\n", " "))
    if title:match "^%s*$" then
      -- title = "no_text"
    else
      return ("[%s](%s)"):format(title, vim.uri_decode(url))
    end
  end
end

---@param src string
---@return string
local function remove_html_tag(src)
  local dst = ""
  local pos = 1
  while pos <= #src do
    local s, e = src:find("<[^>]+>", pos)
    if not s then
      dst = dst .. src:sub(pos)
      break
    end
    dst = dst .. src:sub(pos, s - 1)
    pos = e + 1
  end
  dst = text_util.decode_entity(dst)
  dst = dst:match "(.-)%s*$"

  return dst
end

---@param src string?
---@return string?
local function get_pre_lang(src)
  if not src then
    print "no src"
    return
  end

  local m = src:match '%sdata%-lang="(%w+)"' or ""
  if m and #m > 0 then
    return m
  end

  m = src:match '%sdata%-language="(%w+)"' or ""
  if m and #m > 0 then
    return m
  end

  m = src:match '%sclass="language%-([^"]+)"' or ""
  if m and #m > 0 then
    return m
  end

  -- print('no lang', src)
  return ""
end

---@param lines string[]
---@param body string
local function add_lines(lines, body)
  local parser = vim.treesitter.get_string_parser(body, "html")
  local tree = parser:parse()
  if tree then
    local PushLine = require "PushLine"
    local push_line = PushLine.new(lines, body)

    local root = tree[1]:root()
    traverse(root, function(node)
      local node_type = node:type()
      local text = vim.treesitter.get_node_text(node, body)
      if node_type == "document" then
        return true
      end

      local start_tag_text = text_util.html_get_tag_from_element(body, node)
      local tag
      if start_tag_text then
        tag = start_tag_text:match "^<(%w+)"
        assert(tag)
        tag = tag:lower()
      end
      --   if tag then
      --     if start_tag_text:match "^<a%s" then
      --     end
      --   end
      -- end

      if tag == "a" then
        local link = make_link(body, node)
        if link then
          push_line:push_text(link)
        end
      elseif tag == "pre" then
        local pre = vim.treesitter.get_node_text(node, body, {})
        pre = remove_html_tag(pre)
        local lang = get_pre_lang(start_tag_text)
        push_line:flush_texts()
        push_line:newline()
        push_line:push_line("```" .. lang)
        local pre_lines = vim.split(pre, "\n")
        for _, l in ipairs(pre_lines) do
          push_line:push_line(l)
        end
        push_line:push_line "```"
        push_line:newline()
      elseif tag == "head" then
      elseif tag == "form" then
      elseif tag == "svg" then
      elseif tag == "dialog" then
      elseif tag == "script_element" then
      elseif tag == "style_element" then
      elseif tag == "doctype" then
      elseif tag == "comment" then
      elseif tag == "iframe" then
      elseif node_type == "element" then
        return true
      elseif node_type == "text" or node_type == "entity" then
        push_line:push_text(text_util.decode_entity(text))
      elseif node_type == "start_tag" then
        push_line:start_tag(text)
      elseif node_type == "self_closing_tag" then
        push_line:start_tag(text, true)
      elseif node_type == "end_tag" then
        local parent = node:parent()
        assert(parent)
        local end_tag = text_util.html_get_tag_from_element(body, parent)
        assert(end_tag)
        push_line:end_tag(end_tag)
      else
        print(node_type)
      end

      return false
    end)

    push_line:flush_texts()

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
---@param responses [string, string][]
---@return MsgMap
local function add_http_header(lines, responses)
  table.insert(lines, "---")
  table.insert(lines, "# vim: ft=markdown")
  table.insert(lines, "responses: [")

  ---@type MsgMap
  local map = {}

  for i, res in ipairs(responses) do
    local status, header = unpack(res)
    table.insert(lines, "  {")
    table.insert(lines, '    "status": "' .. status .. '"')
    table.insert(lines, '    "http-header": {')
    for k, v in header:gmatch "([^:]+):%s*(.-)\r\n" do
      if i == #responses then
        map[k] = v
      end
      table.insert(lines, '      "' .. k .. '": "' .. v .. '"')
    end
    table.insert(lines, "    },")
    table.insert(lines, "  },")
  end
  table.insert(lines, "]")
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

  local responses = {}

  while #res > 0 do
    local status, header, body = res:match "^(HTTP.-)\r\n(.-)\r\n\r\n(.*)$"
    if status then
      print(status)
      table.insert(responses, { status, header })
      res = body
    else
      break
    end
  end
  body = res
  assert(#body > 0)

  ---@type string[]
  local lines = {}
  local map = add_http_header(lines, responses)
  local fold_end = #lines
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

  vim.keymap.set("n", "j", "gj", { buffer = ev.buf, noremap = true })
  vim.keymap.set("n", "k", "gk", { buffer = ev.buf, noremap = true })
  vim.cmd "norm! gg"
  vim.cmd("norm! " .. (fold_end + 1) .. "j")
  vim.cmd "norm! zt"
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
