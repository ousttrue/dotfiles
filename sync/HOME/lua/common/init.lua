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
---@return string system_name lowercase. 'windows', 'wsl', 'linux'...etc
---@return string? sub_system lowercase. 'ubuntu', 'arch', 'gentoo', 'msys2', 'msysgit', 'mingw64'...etc
local function get_system()
  local wsl = os.getenv "WSL_DISTRO_NAME"
  if wsl then
    return "wsl", wsl
  end

  if os.getenv "USERPROFILE" then
    local msys = os.getenv "MSYSTEM"
    if msys then
      return "windows", msys:lower()
    else
      return "windows"
    end
  end

  local f = io.open("/etc/os-release", "r")
  if f then
    local content = f:read("*a"):lower()
    if content:match "ubuntu" then
      return "linux", "ubuntu"
    elseif content:match "arch" then
      return "linux", "arch"
    else
      return "linux"
    end
    f:close()
  else
    return "linux"
  end
end
local system_name, sub_system = get_system()

function M.get_system()
  -- cache
  -- M.get_system = function()
  --   return system_name, sub_system
  -- end

  return system_name, sub_system
end

M.system_map = {
  windows = " ",
  wsl = "󰰮 ",
  linux = " ",
  osx = " ",
}

M.subsystem_map = {
  msys = "󰰐 ",
  ubuntu = " ",
  gentoo = " ",
  arch = " ",
}

M.day_map = {
  ["0"] = "日",
  ["1"] = "月",
  ["2"] = "火",
  ["3"] = "水",
  ["4"] = "木",
  ["5"] = "金",
  ["6"] = "土",
}

function M.to_path(src)
  if system_name == "windows" then
    return string.gsub(src, "/", "\\")
  else
    return string.gsub(src, "\\", "/")
  end
end

return M
