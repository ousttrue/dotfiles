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

return TSNodePath
