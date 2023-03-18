local M = {}

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

-- https://github.com/stuta/Luajit-Tcp-Server/blob/master/win_kernel32.lua
local ffi = require "ffi"
local kernel32 = ffi.load "kernel32"

ffi.cdef [[
typedef unsigned int	UINT;
typedef long			BOOL;
typedef BOOL *			LPBOOL;
typedef unsigned long	DWORD;
typedef char *			LPSTR;
typedef const char *	LPCSTR;
typedef short *			LPWSTR;
typedef const short *	LPCWSTR;

int MultiByteToWideChar(UINT CodePage,
    DWORD    dwFlags,
    LPCSTR   lpMultiByteStr, int cbMultiByte,
    LPWSTR  lpWideCharStr, int cchWideChar);


int WideCharToMultiByte(UINT CodePage,
    DWORD    dwFlags,
	LPCWSTR  lpWideCharStr, int cchWideChar,
    LPSTR   lpMultiByteStr, int cbMultiByte,
    LPCSTR   lpDefaultChar,
    LPBOOL  lpUsedDefaultChar);
]]

local CP_ACP = 0 -- default to ANSI code page
local CP_OEMCP = 1 -- default to OEM code page
local CP_MACCP = 2 -- default to MAC code page
local CP_THREAD_ACP = 3 -- current thread's ANSI code page
local CP_SYMBOL = 42 -- SYMBOL translations
local CP_UTF8 = 65001

local function ToWide(in_Src, codepage)
  if not in_Src then
    print "ToWide: nil"
    return nil
  end
  -- find out how many characters needed
  local charsneeded = kernel32.MultiByteToWideChar(codepage, 0, in_Src, #in_Src, nil, 0)
  if charsneeded < 0 then
    print "ToWide: -1"
    return nil
  end
  print("charsneeded: ", charsneeded)

  local buff = ffi.new("uint16_t[?]", charsneeded + 1)
  local charswritten = kernel32.MultiByteToWideChar(codepage, 0, in_Src, #in_Src, buff, charsneeded)
  buff[charswritten] = 0
  print("ToWide: ", charswritten)
  return buff
end

local function ToMultiByte(in_Src, codepage)
  if not in_Src then
    print "ToMultiByte: nil"
    return nil
  end
  -- find out how many characters needed
  local bytesneeded = kernel32.WideCharToMultiByte(codepage, 0, in_Src, -1, nil, 0, nil, nil)
  if bytesneeded <= 0 then
    print "ToMultiByte: -1"
    return nil
  end

  local buff = ffi.new("uint8_t[?]", bytesneeded + 1)
  local byteswritten = kernel32.WideCharToMultiByte(codepage, 0, in_Src, -1, buff, bytesneeded, nil, nil)
  buff[byteswritten] = 0

  local ret = ffi.string(buff, byteswritten - 1)
  print("ToMultiByte: ", byteswritten)
  return ret
end

function M.cp932_to_utf8(src)
  local wide = ToWide(src, 932)
  return ToMultiByte(wide, CP_UTF8)
end

return M
