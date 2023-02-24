-- # pwd based on the value of _ZO_RESOLVE_SYMLINKS.
local function __zoxide_pwd()
  return nyagos.exec "pwd -L"
end

-- cd + custom logic based on the value of _ZO_ECHO.
local function __zoxide_cd(arg)
  -- shellcheck disable=SC2164
  nyagos.exec("cd " .. arg)
end

local ZOXIDE_EXISTS = "/.ZOXIDE_EXISTS"

local function exists_directory(current)
  local path = current .. ZOXIDE_EXISTS
  local f = io.open(path, "w+")
  if f then
    io.close(f)
    os.remove(path)
    return true
  else
    return false
  end
end

local function __zoxide_z(args)
  local arg = unpack(args)
  -- shellcheck disable=SC2199
  if arg == nil then
    __zoxide_cd "~"
  else
    -- elseif #arg == 1 then
    if exists_directory(arg) then
      __zoxide_cd(arg)
    else
      -- \builtin local result
      local pwd = __zoxide_pwd() or "true"
      local result = nyagos.eval("zoxide query --exclude " .. pwd .. " -- " .. arg)
      __zoxide_cd(result)
    end
  end
end

local M = {}

function M.setup()
  nyagos.alias.z = __zoxide_z
end

return M
