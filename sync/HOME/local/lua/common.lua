local M = {}

--
-- https://gist.github.com/un-def/914b1a93181e43e8a2adc35ad5c9b03a
-- http://lua-users.org/lists/lua-l/2016-05/msg00297.html
--
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

return M
