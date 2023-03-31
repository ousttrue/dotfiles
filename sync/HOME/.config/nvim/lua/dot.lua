local M = {}

M.is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

function M.get_home()
  if vim.fn.has "win32" == 1 then
    return vim.env.USERPROFILE
  else
    return vim.env.HOME
  end
end

function M.get_config_home()
  if vim.env.XDG_CONFIG_HOME then
    return vim.env.XDG_CONFIG_HOME
  elseif vim.env.HOME then
    return vim.env.HOME .. "/.config"
  else
    return vim.env.APPDATA .. "/.config"
  end
end

function M.get_suffix()
  if vim.fn.has "win32" == 1 then
    return ".exe"
  else
    return ""
  end
end

M._border = {
  { "┏", "FloatBorder" }, -- upper left
  { "━", "FloatBorder" }, -- upper
  { "┓", "FloatBorder" }, -- upper right
  { "┃", "FloatBorder" }, -- right
  { "┛", "FloatBorder" }, -- lower right
  { "━", "FloatBorder" }, -- lower
  { "┗", "FloatBorder" }, -- lower left
  { "┃", "FloatBorder" }, -- left
}

M.border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

---@param str string
---@param pattern string
---@return fun(): integer, integer
function M.gfind(str, pattern)
  local from_idx = nil
  local to_idx = 0
  return function()
    from_idx, to_idx = string.find(str, pattern, to_idx + 1)
    return from_idx, to_idx
  end
end

---@param str string
---@param pattern string
---@return string[]
function M.split(str, pattern)
  local p = 1
  local result = {}

  for f, t in M.gfind(str, pattern) do
    table.insert(result, string.sub(str, p, f - 1))
    p = t + 1
  end
  table.insert(result, string.sub(str, p, -1))
  return result
end

return M
