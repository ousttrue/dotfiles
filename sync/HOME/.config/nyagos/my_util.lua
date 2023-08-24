--
-- https://qiita.com/gp333/items/c472f7a7d9fcca1b5cb7
--
local M = {}

function M.trim(s)
  if s then
    return string.match(s, "^%s*(.*)"):match "(.-)%s*$"
  end
end

function M.join(args, delimiter)
  local cmd = ""
  delimiter = delimiter or " "
  for _, arg in ipairs(args) do
    cmd = cmd .. delimiter .. arg
  end
  return cmd
end

function M.split(str, delimiter)
  local t = {}
  for s in string.gmatch(str, string.format("([^%s]+)", delimiter)) do
    table.insert(t, M.trim(s))
  end
  return t
end

-- function M.exec(cmd, ...)
--   local args = { ... }
--   if #args > 0 then
--     cmd = string.format('"%s" %s', cmd, M.join(args))
--   end
--   return nyagos.exec(cmd)
-- end

function M.eval(...)
  return M.trim(nyagos.raweval(...))
end

function M.has_git()
  local path = nyagos.getwd()
  repeat
    if nyagos.access(nyagos.pathjoin(path, ".git"), 0) then
      return true
    end
    path = string.match(path, "^(.+)\\")
  until not path
end

return M
