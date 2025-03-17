local utf8 = require "neoskk.utf8"
local RequestMap = {}
RequestMap.__index = RequestMap

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
  print("node", node)
  if node and node:type() == "link_destination" then
    return node
  end
end

---@param uri string
---@return string?
local function if_exists(uri)
  local path = uri .. ".md"
  if vim.uv.fs_stat(path) then
    return path
  end
  path = uri .. "/index.md"
  if vim.uv.fs_stat(path) then
    return path
  end
end

---@param root_dir string
---@param dir string
---@param dst string
local function make_uri(root_dir, dir, dst)
  if dst:find "^/" then
    local uri = vim.fs.joinpath(root_dir, dst)
    return if_exists(uri)
  else
    local uri = vim.fs.joinpath(dir, dst)
    return if_exists(uri)
  end
end

---@class lls.WorkSpace
---@field root_dir string
local WorkSpace = {}
WorkSpace.__index = WorkSpace

---@return lls.WorkSpace
function WorkSpace.new(root_dir)
  print("WorkSpace.new =>", root_dir)
  local self = setmetatable({
    root_dir = root_dir,
  }, WorkSpace)
  return self
end

---@param params lsp.DefinitionParams
---@return lsp.ResponseError?
---@return lsp.Location?
function WorkSpace:lsp_definition(params)
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
      local pos = { line = 0, character = 0 }
      return nil,
          {
            uri = uri,
            range = {
              start = pos,
              ["end"] = pos,
            },
          }
    else
      print("no found", dir, dst)
    end
  else
    print("no node", vim.inspect(pos))
  end
end

---@alias RootType 'docusaurus'|'git'

---@param root_dir string
---@param root_type RootType
---@return table<string, lls.Method> request_map
function RequestMap.make_request_map(root_dir, root_type)
  local ws
  -- if root_type == "docusaurus" then
  --   ws = WorkSpace.new(vim.fs.joinpath(root_dir, "docs"))
  -- else
  ws = WorkSpace.new(root_dir)
  -- end

  local request_map = {}

  request_map[vim.lsp.protocol.Methods.textDocument_definition] = function(...)
    return ws:lsp_definition(...)
  end

  return request_map
end

return RequestMap
