--
-- https://qiita.com/gp333/items/c472f7a7d9fcca1b5cb7
--
local M = {}

local cm_str = require "common.string"

function M.exec(cmd, ...)
  local args = { ... }
  if #args > 0 then
    cmd = string.format('"%s" %s', cmd, M.join(args))
  end
  return nyagos.exec(cmd)
end

function M.eval(...)
  -- 終了を待ってしまう？(vim とかだと固まる？)
  return cm_str.trim(nyagos.raweval(...))
end

function M.has_git()
  local path = nyagos.getwd()
  repeat
    if nyagos.access(nyagos.pathjoin(path, ".git"), 0) then
      return true
    end
    path = string.match(path, "^(.+)[\\/]")
  until not path
end

return M
