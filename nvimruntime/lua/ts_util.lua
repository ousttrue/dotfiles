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

return M
