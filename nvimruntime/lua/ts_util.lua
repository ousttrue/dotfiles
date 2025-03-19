local utf8 = require "neoskk.utf8"
local M = {}

---@param node TSNode
---@param type_name string
---@return TSNode?
function M.find_child_by_type(node, type_name)
  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      if child:type() == type_name then
        return child
      end
    end
  end
end

---@param src string
---@param node TSNode
---@return string?
function M.html_get_tag_from_element(src, node)
  if node:type() ~= "element" then
    return
  end

  local child = M.find_child_by_type(node, "start_tag")
  if not child then
    return
  end

  return vim.treesitter.get_node_text(child, src)
end

local ENTITY_MAP = {
  amp = "&",
}

---@param src string
---@return string
function M.decode_entity(src)
  src = src:gsub("(&(#?)(x?)(%w+);)", function(all, n, x, w)
    if n and #n>0 then
      if x and #x>0 then
        return utf8.char(tonumber(w, 16))
      else
        -- return utf8.char(tonumber(w))
        return all
      end
    else
      return ENTITY_MAP[w]
    end
  end)
  return src
end

---@param src string
---@param node TSNode
---@param lines string[]
function M.get_text(src, node, lines)
  local node_type = node:type()
  if node_type == "text" or node_type == "entity" then
    local text = vim.treesitter.get_node_text(node, src)
    if #text > 0 then
      text = M.decode_entity(text)
      table.insert(lines, text)
    end
  end

  for i = 0, node:named_child_count() - 1 do
    local child = node:named_child(i)
    if child then
      M.get_text(src, child, lines)
    end
  end
end

return M
