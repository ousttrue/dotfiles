local M = {}
local COM = require "common"
local STR = require "common.string"
local NYA = require "nya.util"

local function iter_dir(dir)
  local files = STR.split(nyagos.eval("fd -H -t f . " .. dir), "\n")
  local i = 0
  return function()
    i = i + 1
    local f = files[i]
    if f then
      return f
    end
  end
end

---@param base_dir string
---@param dst_dir string
function M.create_links(base_dir, dst_dir)
  for src in iter_dir(base_dir) do
    local rel = string.sub(src, #base_dir + 2)
    local dst = COM.to_path(dst_dir .. "/" .. rel)
    if NYA.is_exists(dst) then
      print("-", src)
    else
      print(".", src)
      NYA.evalf("ln -sf %s %s", src, dst)
    end
  end
end

return M
