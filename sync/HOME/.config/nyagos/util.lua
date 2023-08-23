local M = {}
function M.trim(s)
  return s:match("^%s*(.*)"):match "(.-)%s*$"
end

function M.join(args, delimiter)
  local cmd = ""
  delimiter = delimiter or " "
  for _, arg in ipairs(args) do
    cmd = cmd .. delimiter .. arg
  end
  return cmd
end

function M.exec(cmd, ...)
  local args = { ... }
  if #args > 0 then
    cmd = string.format('"%s" %s', cmd, M.join(args))
  end
  return nyagos.exec(cmd)
end

return M
