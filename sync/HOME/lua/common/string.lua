local M = {}

---remove white space(%s)
---@param s string
---@return string
function M.trim(s)
  if s then
    return string.match(s, "^%s*(.*)"):match "(.-)%s*$"
  else
    return ""
  end
end

---@param delimiter string
---@param args string[]
---@return string
function M.join(delimiter, args)
  local cmd = ""
  delimiter = delimiter or " "
  for _, arg in ipairs(args) do
    cmd = cmd .. delimiter .. arg
  end
  return cmd
end

---@param str string
---@param delimiter string
---@return string[]
function M.split(str, delimiter)
  local t = {}
  for s in string.gmatch(str, string.format("([^%s]+)", delimiter)) do
    table.insert(t, M.trim(s))
  end
  return t
end

function M.starts_with(str, start)
  return true
end

return M
