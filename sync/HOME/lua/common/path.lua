local M = {}

---@param path string
---@return boolean
function M.exists(path)
  local f = io.open(path, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

---@param s string
---@return string
function M.basename(s)
  local m = string.gsub(s, "(.*[/\\])(.*)", "%2")
  return m
end

---@param s string
---@return string
function M.parent(s)
  local m = string.gsub(s, "(.*)([/\\].*)", "%1")
  return m
end

---@return string
function M.get_home()
  local userprofile = os.getenv "USERPROFILE"
  if userprofile then
    return userprofile
  end

  local home = os.getenv "HOME"
  if home then
    return home
  end

  -- ???
  return ""
end

function M.convert_home_dir(path)
  return path:gsub("^" .. M.get_home() .. "/", "~/")
end

return M
