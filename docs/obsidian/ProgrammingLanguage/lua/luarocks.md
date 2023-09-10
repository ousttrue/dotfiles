[[lua]]

[LuaRocks - The Lua package manager](https://luarocks.org/)

# articles
- @2017 [LuaRocksで環境ごとにパッケージをインストールしてパスを通す - Qiita](https://qiita.com/iwai/items/61419987a1d859245dde#lua_path)
- @2014 [LuaRocks で Lua のモジュールを管理する - Qiita](https://qiita.com/mah0x211/items/a07a2628f129285a9337)

# install
普通の lua script。だが、
```
/usr/bin/lua5.1: /usr/bin/luarocks:4: module 'luarocks.core.cfg' not found:
```
[Windows mingw compilation issues - module 'luarocks.core.cfg' not found · Issue #885 · luarocks/luarocks · GitHub](https://github.com/luarocks/luarocks/issues/885)

```lua
#!/usr/bin/env lua-any
-- Lua-Versions: 5.1 5.2 5.3 5.4
-- Load cfg first so that the loader knows it is running inside LuaRocks
local cfg = require("luarocks.core.cfg")

local loader = require("luarocks.loader")
local cmd = require("luarocks.cmd")

local description = "LuaRocks main command-line interface"

local commands = {
   init = "luarocks.cmd.init",
   pack = "luarocks.cmd.pack",
   unpack = "luarocks.cmd.unpack",
   build = "luarocks.cmd.build",
   install = "luarocks.cmd.install",
   search = "luarocks.cmd.search",
   list = "luarocks.cmd.list",
   remove = "luarocks.cmd.remove",
   make = "luarocks.cmd.make",
   download = "luarocks.cmd.download",
   path = "luarocks.cmd.path",
   show = "luarocks.cmd.show",
   new_version = "luarocks.cmd.new_version",
   lint = "luarocks.cmd.lint",
   write_rockspec = "luarocks.cmd.write_rockspec",
   purge = "luarocks.cmd.purge",
   doc = "luarocks.cmd.doc",
   upload = "luarocks.cmd.upload",
   config = "luarocks.cmd.config",
   which = "luarocks.cmd.which",
   test = "luarocks.cmd.test",
}

cmd.run_command(description, commands, "luarocks.cmd.external", ...)
```

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
