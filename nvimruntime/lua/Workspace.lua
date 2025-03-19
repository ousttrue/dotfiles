local utf8 = require "neoskk.utf8"

---@param bufnr integer
---@param pos [integer, integer] row, col
---@return TSNode?
local function get_link_destination(bufnr, pos)
  local node = vim.treesitter.get_node {
    bufnr = bufnr,
    pos = pos,
    ignore_injections = false,
    -- lang = "markdown_inline",
  }
  if not node then
    return
  end

  if node:type() == "link_destination" then
    return node
  end

  if node:type() == "link_text" then
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

  print("node", node:type())
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

  if dst:find "^/" then
    local host = dir:match "^(https?://[^/]+)"
    if host then
      return host .. dst
    else
      local uri = vim.fs.joinpath(root_dir, dst)
      return if_exists(uri)
    end
  elseif dst:find "^%./" then
    local uri = vim.fs.joinpath(dir, dst:sub(3))
    return if_exists(uri)
  else
    local uri = vim.fs.joinpath(dir, dst)
    return if_exists(uri)
  end
end

---@class lls.Workspace
---@field root_dir string
local Workspace = {}
Workspace.__index = Workspace

---@return lls.Workspace
function Workspace.new(root_dir)
  local self = setmetatable({
    root_dir = root_dir,
  }, Workspace)
  return self
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
  local node = get_link_destination(bufnr, pos)

  if node then
    local dir = vim.fs.dirname(params.textDocument.uri)
    local ts_utils = require "nvim-treesitter.ts_utils"
    local dst = ts_utils.get_node_text(node)[1]
    -- local dst = vim.treesitter.get_node_text(node, bufnr)
    if dst:find "/$" then
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
