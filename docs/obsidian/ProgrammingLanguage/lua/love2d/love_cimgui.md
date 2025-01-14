https://love2d.org/wiki/cimgui-love

internal を含むように生成。

```sh
> cd cimgui
cimgui> LUA_PATH=./?.lua D:/msys64/mingw64/bin/luajit generator.lua cl "internal freetype"
cimgui> cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-DIMGUI_USE_WCHAR32=1
cimgui> cmake --build build
cimgui> ls build
build/cmake.dll
> LUA_PATH=./?.lua D:/msys64/mingw64/bin/luajit generator.lua
```

## config

- [Config file format · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Config-file-format)

```lua
-- config-5.1.lua
local_by_default=true
config={
	variables={
		MD5SUM = [[D:/msys64/usr/bin/md5sum.exe]],
	}
}
```

## Windows

- [GitHub - luarocks/luarocks: LuaRocks is the package manager for the Lua programming language.](https://github.com/luarocks/luarocks/tree/master)
- [Installation instructions for Windows · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows)
  `install.bat` を改造するべし

```lua
# 独立したフォルダを指定するのがよい(クリアされる)
> luajit install.bat /P %USERPROFILE%/luarocks /NOADMIN /MW /F
```

### tools

ダブルクォートが余分について `md5sum` のサーチに失敗する。

```lua
-- luarocks config
variables = {
   MD5SUM = "\"C:/User/bin/tools/md5sum.exe\"", -- 👈
}
```

👇

```lua
--config-5.1.lua
variables = {
  MD5SUM = [[D:/msys64/usr/bin/md5sum.exe]],
}
```

`tools`

```lua
function unquote(str)
  if string.sub(str, 1, 1)=='"' and string.sub(str, -1)=='"' then
    return string.sub(str, 2,-2)
  else
    return str
  end
end
```
