[[lua]]

[LuaRocks - The Lua package manager](https://luarocks.org/)

# articles
- @2017 [LuaRocksで環境ごとにパッケージをインストールしてパスを通す - Qiita](https://qiita.com/iwai/items/61419987a1d859245dde#lua_path)
- @2014 [LuaRocks で Lua のモジュールを管理する - Qiita](https://qiita.com/mah0x211/items/a07a2628f129285a9337)

# install
```sh
> luarocks path
export LUA_PATH='
${PREFIX}/share/lua/5.1/?.lua;
${LUA_PATH};
${USER_ROKCS}/share/lua/5.1/?.lua;
${USER_ROKCS}/share/lua/5.1/?/init.lua;
${PREFIX}/share/lua/5.1/?/init.lua
'

export LUA_CPATH='
./?.so;
/usr/local/lib/lua/5.1/?.so;
/usr/lib/x86_64-linux-gnu/lua/5.1/?.so;
/usr/local/lib/lua/5.1/loadall.so;
${USER_ROCKS}/lib/lua/5.1/?.so;
${PREFIX}/lib/lua/5.1/?.so
'

export PATH='
${USER_ROCKS}/bin:
${PATH}:
${PREFIX}/bin:
'
```

## config
```lua
-- config-5.1.lua
local_by_default=true
config={
	variables={
		MD5SUM="",
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

## Posix

```
$ ./configure --prefix=$HOME/prefix
$ make install
```

# system-wide
`/usr/local/lib/luarocks`
=>
`/usr/local/lib/luarocks/bin/`

# per-user
`$HOME/.luarocks/rocks/`
=>
`$HOME/.luarocks/bin/`

# per-project

# hererocks
- [GitHub - luarocks/hererocks: Python script for installing Lua/LuaJIT and LuaRocks into a local directory](https://github.com/luarocks/hererocks)
- [Windows環境にluarocksをインストールするにはhererocksが便利 | Birth, Gaming, Gaming, Death](https://bggd.github.io/2019/12/20/hererocks-on-windows.html)

`$ pip install hererocks`
master
``$ pip install git+https://github.com/luarocks/hererocks`

`$ hererocks.exe lua -l latest -r latest --target vs`
