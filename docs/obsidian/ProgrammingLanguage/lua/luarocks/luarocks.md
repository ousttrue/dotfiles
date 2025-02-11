[LuaRocks - The Lua package manager](https://luarocks.org/)

- https://github.com/luarocks/luarocks/wiki/Documentation

# install for exists lua interpreter

https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows

## windows

```sh
> install.bat
```

# Rocks repositories

https://github.com/luarocks/luarocks/wiki/Rocks-repositories

```
 {base}                (base rocks tree directory)
  ├── luarocks/config-5.1.lua
  ├── bin              (deployment of command line scripts)
  ├── lib
  │    ├── luarocks
  │    │    └── rocks  (contains manifest and sub-dirs with rocks)
  │    │
  │    └── lua
  │         └── 5.1    (deployment of binary modules)
  │
  └── share
       └── lua
            └── 5.1    (deployment of Lua modules)
```

## config file

https://github.com/luarocks/luarocks/wiki/Config-file-format

## system

## user(local)

## manifest(project)

- @2014 [LuaRocks で Lua のモジュールを管理する #GitHub - Qiita](https://qiita.com/mah0x211/items/a07a2628f129285a9337#github-%E3%81%AE%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%A7%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E7%AE%A1%E7%90%86)

# luarocks-admin

https://github.com/luarocks/luarocks/wiki/luarocks-admin

## make-manifest

https://github.com/luarocks/luarocks/wiki/make-manifest

# articles

- https://leafo.net/guides/customizing-the-luarocks-tree.html#the-install-locations/using-a-custom-directory
- @2017 [LuaRocksで環境ごとにパッケージをインストールしてパスを通す - Qiita](https://qiita.com/iwai/items/61419987a1d859245dde#lua_path)
- @2014 [LuaRocks で Lua のモジュールを管理する - Qiita](https://qiita.com/mah0x211/items/a07a2628f129285a9337)

# tree

## lfs

```
%APPDATA%/LuaRocks/lib/lua/5.1/lfs.dll
```

# install

- [Installation instructions for Windows · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Installation-instructions-for-Windows)

- [File locations · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/File-locations)

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

# luajit-rocks

https://qiita.com/suzuryo3893/items/bd7685ea49ac81bad6f3

# hererocks

- [GitHub - luarocks/hererocks: Python script for installing Lua/LuaJIT and LuaRocks into a local directory](https://github.com/luarocks/hererocks)
- [Windows環境にluarocksをインストールするにはhererocksが便利 | Birth, Gaming, Gaming, Death](https://bggd.github.io/2019/12/20/hererocks-on-windows.html)

`$ pip install hererocks`
master
``$ pip install git+https://github.com/luarocks/hererocks`

`$ hererocks.exe lua -l latest -r latest --target vs`
