---https://github.com/luarocks/lua-style-guide
---https://luals.github.io/
local M = {}

---
---https://gist.github.com/un-def/914b1a93181e43e8a2adc35ad5c9b03a
---http://lua-users.org/lists/lua-l/2016-05/msg00297.html
---
function M.get_lua_version()
  if ({ false, [1] = true })[1] then -- luacheck: ignore 314
    return "LuaJIT"
  elseif 1 / 0 == 1 / "-0" then
    return 0 + "0" .. "" == "0" and "Lua-5.4" or "Lua-5.3"
  end
  local f = function()
    return function() end
  end
  return f() == f() and "Lua-5.2" or "Lua-5.1"
end

---detect system.
---@return string system_name lowercase. 'windows', 'linux'...etc
function M.get_system()
  if os.getenv "USERPROFILE" then
    return "windows"
  else
    return "linux"
  end
  -- if vim.fn.has "wsl" ~= 0 then
  --   return "wsl"
  -- elseif vim.fn.has "win64" ~= 0 then
  --   if vim.env.MSYSTEM then
  --     vim.opt.shellcmdflag = "-c"
  --     return string.lower(vim.env.MSYSTEM)
  --   else
  --     return "windows"
  --   end
  -- elseif vim.fn.has "mac" ~= 0 then
  --   return "mac"
  -- elseif vim.fn.has "linux" ~= 0 then
  --   return "linux"
  -- end
end

return M
