local M = {}

if vim.fn.has "win32" == 0 then
  return M
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

	UINT GetConsoleCP(void);

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

function M.get_codepage()
  -- local ret =
  --   vim.fn.system [[pwsh -NoProfile -Command "Get-ItemPropertyValue HKLM:\SYSTEM\CurrentControlSet\Control\Nls\CodePage OEMCP"]]
  -- local cp = tonumber(ret)
  -- return cp
  return kernel32.GetConsoleCP()
  -- return 932
end

local function ToWide(in_Src, codepage)
  if not in_Src then
    -- print "ToWide: nil"
    return nil
  end
  -- find out how many characters needed
  local charsneeded = kernel32.MultiByteToWideChar(codepage, 0, in_Src, #in_Src, nil, 0)
  if charsneeded < 0 then
    -- print "ToWide: -1"
    return nil
  end
  -- print("charsneeded: ", charsneeded)

  local buff = ffi.new("uint16_t[?]", charsneeded + 1)
  local charswritten = kernel32.MultiByteToWideChar(codepage, 0, in_Src, #in_Src, buff, charsneeded)
  buff[charswritten] = 0
  -- print("ToWide: ", charswritten)
  return buff
end

local function ToMultiByte(in_Src, codepage)
  if not in_Src then
    -- print "ToMultiByte: nil"
    return nil
  end
  -- find out how many characters needed
  local bytesneeded = kernel32.WideCharToMultiByte(codepage, 0, in_Src, -1, nil, 0, nil, nil)
  if bytesneeded <= 0 then
    -- print "ToMultiByte: -1"
    return nil
  end

  local buff = ffi.new("uint8_t[?]", bytesneeded + 1)
  local byteswritten = kernel32.WideCharToMultiByte(codepage, 0, in_Src, -1, buff, bytesneeded, nil, nil)
  buff[byteswritten] = 0

  local ret = ffi.string(buff, byteswritten - 1)
  -- print("ToMultiByte: ", byteswritten)
  return ret
end

local cp = M.get_codepage()
if cp == CP_UTF8 then
  function M.to_utf8(src)
    return src
  end
else
  function M.to_utf8(src)
    local wide = ToWide(src, cp)
    return ToMultiByte(wide, CP_UTF8)
  end
end

return M
