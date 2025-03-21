local utf8 = require "neoskk.utf8"
local ts_utils = require "nvim-treesitter.ts_utils"

---@param node TSNode?
---@return TSNode?
local function get_link_destination(node)
  if not node then
    return
  end

  local node_type = node:type()
  if node_type == "link_destination" then
    return node
  end

  if node_type == "link_text" then
    local parent = node:parent()
    if parent then
      for i = 0, parent:named_child_count() - 1 do
        local child = parent:named_child(i)
        if child then
          if child:type() == "link_destination" then
            return child
          end
        end
      end
    end
  end

  if node_type == "inline_link" then
    local parent = node
    for i = 0, parent:named_child_count() - 1 do
      local child = parent:named_child(i)
      if child then
        if child:type() == "link_destination" then
          return child
        end
      end
    end
  end

  print("get_link_destination: link_destination not found", node:type())
end

---@param uri string
---@return string?
local function if_exists(uri)
  print("uri:", uri)
  if uri:find "^file:/" then
    uri = uri:sub(7)
  end

  local path = uri .. ".md"
  if vim.uv.fs_stat(path) then
    return path
  end
  path = uri .. "/index.md"
  if vim.uv.fs_stat(path) then
    return path
  end

  print(("not exits: '%s'"):format(uri))
end

---@param root_dir string
---@param dir string
---@param dst string
local function make_uri(root_dir, dir, dst)
  if dst:find "^https?://" then
    return dst
  end

  print("make_uri", root_dir, dir, dst)
  local host = dir:match "^(https?://[^/]+)"
  if host then
    -- http
    if dst:find "^/" then
      -- absolute path
      print("http + abs", host, dst)
      return host .. dst
    else
      -- relative
      if dst:find "^%./" then
        dst = dst:sub(3)
      end
      print("http + rel", dir, dst)
      return dir .. "/" .. dst
    end
  else
    -- local filesysem
    if dst:find "^/" then
      -- absolute path
      local uri = vim.fs.joinpath(root_dir, dst)
      print("local + abs", uri)
      return if_exists(uri)
    else
      -- relative
      if dst:find "^%./" then
        dst = dst:sub(3)
      end
      local uri = vim.fs.joinpath(dir, dst)
      print("local + rel", uri)
      return if_exists(uri)
    end
  end

  -- else
  --   if host then
  --   else
  --   end
  -- end
end

---@class lls.Workspace
---@field root_dir string
local Workspace = {}
Workspace.__index = Workspace

---@return lls.Workspace
function Workspace.new(root_dir)
  print("Workspace: ", root_dir)
  local self = setmetatable({
    root_dir = root_dir,
  }, Workspace)
  return self
end

local function get_base(uri)
  if uri:sub(#uri) == "/" then
    return uri
  end

  local host, path = uri:match "^(https?://[^/]+)(.*)"
  if host then
    return host .. vim.fs.dirname(path)
  else
    return vim.fs.dirname(uri)
  end
end

---@param params lsp.DefinitionParams
---@return lsp.ResponseError?
---@return lsp.Location?
function Workspace:lsp_definition(params)
  -- print(vim.inspect(params))
  local bufnr = vim.uri_to_bufnr(params.textDocument.uri)
  local row = params.position.line
  local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, true)[1]
  local col = 0
  local char = 0
  for i in utf8.codes(line) do
    if char == params.position.character then
      col = i
      break
    end
    char = char + 1
  end
  local pos = {
    params.position.line,
    col,
  }

  local node = vim.treesitter.get_node {
    bufnr = bufnr,
    pos = pos,
    ignore_injections = false,
    -- lang = "markdown_inline",
  }
  local dst
  if node then
    local link_dst = get_link_destination(node)
    if link_dst then
      dst = ts_utils.get_node_text(link_dst)[1]
    elseif node:type() == "inline" then
      local text = ts_utils.get_node_text(node)[1]
      local m = text:match "^https?://[%w%%%-%+%./#&=]+"
      print(text, m)
      if m then
        dst = m
      end
    end
  end

  if dst then
    local dir = get_base(params.textDocument.uri)
    if dst ~= "/" and dst:find "/$" then
      dst = dst:sub(1, #dst - 1)
    end
    local uri = make_uri(self.root_dir, dir, dst)
    if uri then
      return nil,
          {
            uri = uri,
            range = {
              start = { line = 0, character = 0 },
              ["end"] = { line = 0, character = 0 },
            },
          }
    else
      print("not found", dir, dst)
    end
  else
    print("no node", vim.inspect(pos))
  end
end

return Workspace
