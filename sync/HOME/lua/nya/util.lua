--
-- https://qiita.com/gp333/items/c472f7a7d9fcca1b5cb7
--
local M = {}

local cm_str = require "common.string"

-- function M.exec(cmd, ...)
--   local args = { ... }
--   if #args > 0 then
--     cmd = string.format('"%s" %s', cmd, M.join(args))
--   end
--   return nyagos.exec(cmd)
-- end

---pipe など redirection は使えない。quote 不要
---終了を待ってしまう？(vim とかだと固まる？)
---@return string
function M.raweval(...)
  return cm_str.trim(nyagos.raweval(...))
end

---pipe など redirection を使える。quote 必要
---終了を待ってしまう？(vim とかだと固まる？)
---@return string
function M.evalf(fmt, ...)
  return cm_str.trim(nyagos.eval(string.format(fmt, ...)))
end

---@return boolean
function M.has_git()
  local path = nyagos.getwd()
  repeat
    if nyagos.access(nyagos.pathjoin(path, ".git"), 0) then
      return true
    end
    path = string.match(path, "^(.+)[\\/]")
  until not path
  return false
end

---@param cmd string
---@return boolean
function M.which(cmd)
  return nyagos.exec(string.format("which %s > NUL 2>&1", cmd)) == 0
end

---@param path string
---@return boolean?
---@return string error
function M.is_readable(path)
  return nyagos.access(path, 4)
end

---@param path string
---@return boolean
function M.is_exists(path)
  return M.is_readable(path) and true or false
end

return M
