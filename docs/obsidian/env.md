
開発環境案
```
[Docker]language server
👆
[Docker]editor toolchain Shell
👆
[Dokcer/git maintenance]ProjectFolder MultiPlexer Shell
👆
[Local]term
👆             👇
[Local]keyboard visualize
```

# lua 関連のファルダ配置
[[luarocks]]

root を決めて、そこに `luarocks` をインストールする。
- LUA_PATH
- CLUA_PATH
- PATH
を設定する。
- `lua` の `bin`, `include`, `lib` への参照
- `lua` をビルドした toolchain への参照
を揃えるべし。

つまり、
- NeoVim
- LuaRocks
- nyagos, wezterm 
を統合したフォルダ配置が必要だ。

`~/build/${TOOLCHAIN}/lua` 


`luajit`
neovim の cmake の subproject 発見能力に問題があり、 
`USE_BUNDLED_LUAJIT=off` の場合は、システムにインストールした `luajit` でないと発見できない。
```
> sudo apt install luajit libluajit-5.1-dev
```

`neovim`
```
> cmake -G Ninja -S cmake.deps/ -B .deps -DCMAKE_BUILD_TYPE=Release -DUSE_BUNDLED_LUAJIT=off

> ldd `which nvim`
        linux-vdso.so.1 (0x00007ffde17f9000)
        libluajit-5.1.so.2 => /lib/x86_64-linux-gnu/libluajit-5.1.so.2 (0x00007f871db72000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f871da8b000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f871d000000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f871da86000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f871da66000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f871dc15000)
```

`luarock`
```sh
BUILD_ROOT=${HOME}/build/gcc
export LD_LIBRARY_PATH=${BUILD_ROOT}/lib/x86_64-linux-gnu
export PKG_CONFIG_PATH=${BUILD_ROOT}/lib/x86_64-linux-gnu/pkgconfig
```

```
> ./configure --prefix=$HOME/build/gcc

Configuring LuaRocks version 3.9.2...

Lua version detected: 5.1
Lua interpreter found: ${HOME}/build/gcc/bin/luajit
lua.h found: ${HOME}/build/gcc/include/lua.h
unzip found in PATH: /usr/bin

Done configuring.

LuaRocks will be installed at......: ${HOME}/build/gcc
LuaRocks will install rocks at.....: ${HOME}/build/gcc
LuaRocks configuration directory...: ${HOME}/build/gcc/etc/luarocks
Using Lua from.....................: ${HOME}/build/gcc
```
# plan
- git
- wezterm
- golang
	- build nyagos
	- symbolic link
- aqua
	- fzf, ghq...
- rustup / cargo
	- globtest

- python3
	- pip install zig ninja cmake
	- build luajit gettext iconv
	- build neovim 
	- luarocks
	- [Using Neovim as Lua interpreter with Luarocks](https://zignar.net/2023/01/21/using-luarocks-as-lua-interpreter-with-luarocks/)

# windows

- llvm-mingw
- golang
- python
	- cmake
	- ninja
- aqua
	- stylua
       - neovim

`%USERPROFILE%/build/llvm-mingw`
に構築
- luajit
- gettext
- iconv
- neovim
- lua language server

- gtk
	- gst

# docker

formatter と language server ? 
