local M = {}

function M.get_system()
  if vim.fn.has "wsl" ~= 0 then
    return "wsl"
  elseif vim.fn.has "win64" ~= 0 then
    return "windows"
  elseif vim.fn.has "mac" ~= 0 then
    return "mac"
  elseif vim.fn.has "linux" ~= 0 then
    return "linux"
  end
end

M.is_wsl = M.get_system() == "wsl"

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

function M.which(exe)
  vim.fn.system(string.format("which %s > /dev/null", exe))
  return vim.v.shell_error == 0
end

function M.exists(path)
  if vim.loop.fs_stat(path) then
    return true
  end
end

function M.extend_hl()
  -- String: literal: true, false, nil, 0, ""
  vim.api.nvim_set_hl(0, "Number", { link = "String" })
  vim.api.nvim_set_hl(0, "Boolean", { link = "String" })

  -- Idetifier: user name: variable
  vim.api.nvim_set_hl(0, "Constant", { link = "Idetifier" })
  vim.api.nvim_set_hl(0, "Type", { link = "Idetifier" })
  vim.api.nvim_set_hl(0, "Preproc", { link = "Idetifier" })
end

function M.reload_hl()
  package.loaded.dot = nil
  require("dot").extend_hl()

  local cs = vim.g.colors_name
  vim.cmd("colorscheme " .. cs)

  vim.api.nvim_set_hl(0, "MatchParen", { link = "DiagnosticOk" })

  vim.api.nvim_set_hl(0, "@function.builtin.lua", { link = "Idetifier" })
  vim.api.nvim_set_hl(0, "@variable.lua", { link = "Idetifier" })

  -- Statement: keyword: if end function local
  vim.api.nvim_set_hl(0, "@storageclass.c", { link = "Statement" })

  -- field
  vim.api.nvim_set_hl(0, "@field.lua", { link = "Special" })
end

return M
