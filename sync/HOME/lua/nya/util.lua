--
-- https://qiita.com/gp333/items/c472f7a7d9fcca1b5cb7
--
local M = {}

local COM = require "common"
local STR = require "common.string"

local NULDEV = COM.get_system() == "windows" and "NUL" or "/dev/null"

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
  return STR.trim(nyagos.raweval(...))
end

---pipe など redirection を使える。quote 必要
---終了を待ってしまう？(vim とかだと固まる？)
---@return string
function M.evalf(fmt, ...)
  return STR.trim(nyagos.eval(string.format(fmt, ...)))
end

---pushd して 連続でコマンドを実行する
---@param chdir string
---@param cmds string[]
---@return integer
function M.batch(chdir, cmds)
  local ret, error = nyagos.exec("pushd " .. chdir .. " >" .. NULDEV)
  if ret ~= 0 then
    print(error)
    return 1
  end

  for _, v in ipairs(cmds) do
    ret, error = nyagos.exec(v)
    if ret ~= 0 then
      print(error)
      break
    end
  end

  nyagos.exec("popd " .. NULDEV)
  return ret
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
---@return string?
---@return string?
function M.which(cmd)
  local res = STR.trim(nyagos.eval(string.format("which %s 2>%s", cmd, NULDEV)))
  if #res == 0 then
    -- which x: not found
    return nil
  end

  -- ln: built-in command
  local m = string.match(res, "^([^:]+): built%-in command")
  -- if m == cmd then
  if m then
    return nil, "builtin"
  end

  -- ls: aliased to lsd.exe $*
  m = string.match(res, "^([^:]+): aliased to ")
  if m == cmd then
    return nil, "alias"
  end

  return res
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
