[[nvim_build]]

対 `msys2 (not MINGW)` 向けビルド。
- msys file sytem
- winpty ?

# @202308
いくつが回避ポイントが有る
- LuaJit
- TreeSitter
- 外部のLuaを使う
- DEBUG_LOG

# MSYS deps
## lua
`generic` に落ちて、`dll` のロード能力が無くなる。
後続の `nlua0` が動かなくなる。
```cmake
    set(LUA_TARGET generic)
```

```cmake
# cmake.deps/cmake/BuildLua.cmake
elseif(CMAKE_SYSTEM_NAME MATCHES "MSYS")
  set(LUA_TARGET linux)

  set(LUA_TARGET msys) # if dll 改造
```

### deps の luaconf.h を改変
sed にできるか？
```c
// .deps\usr\include\luaconf.h
#define LUA_USE_LINUX 1

defined(_WIN32)
👇
0
```

### msys dll build
```Makefile
# .deps\build\src\lua\Makefile
PLATS= aix ansi bsd freebsd generic linux macosx mingw posix solaris msys
TO_LIB= liblua.dll.a

# .deps\build\src\lua\src\Makefile
PLATS= aix ansi bsd freebsd generic linux macosx mingw posix solaris msys

msys:
	$(MAKE) "LUA_A=liblua.dll" "AR=$(CC) -shared -o" MYCFLAGS="-DLUA_USE_LINUX" MYLIBS="-Wl,--export-all-symbols -Wl,--out-implib=liblua.dll.a -ldl" "RANLIB=strip --strip-unneeded" lua luac
```
後続の nlua で `undefined reference`  が解決できん。

## luajit ではなく lua を使う
luajit は msys2 非対応。

```sh
cmake -S cmake.deps -B .deps -G Ninja -DUSE_BUNDLED_LUAJIT=off -DUSE_BUNDLED_LUA=on

cmake --build .deps

# error
#
# fix .deps
#
```

## .deps の修正
### treesitter のソース解凍に失敗する問題
msys のファイルシステムの問題？
tar の中に対応できないパーミッションがあるとか、そういうエラーぽい。
```cmake
# .deps\build\src\treesitter-stamp\extract-treesitter.cmake
# if(NOT rv EQUAL 0)
#   message(STATUS "extracting... [error clean up]")
#   file(REMOVE_RECURSE "${ut_dir}")
#   message(FATAL_ERROR "Extract of '${filename}' failed")
# endif()
```

```sh
> cd .deps/build/downloads/treesitter
> ls
0a1c4d8466efed6ef5971aa03a84ebb0836128b1.tar.gz
> tar xf 0a1c4d8466efed6ef5971aa03a84ebb0836128b1.tar.gz
tar: tree-sitter-0a1c4d8466efed6ef5971aa03a84ebb0836128b1/CONTRIBUTING.md: Cannot create symlink to ‘docs/section-6-contributing.md’: No such file or directory
tar: tree-sitter-0a1c4d8466efed6ef5971aa03a84ebb0836128b1/script/reproduce: Cannot create symlink to ‘run-fuzzer’: No such file or directory
tar: Exiting with failure status due to previous errors

> cp -rp .deps/build/downloads/treesitter/tree-sitter-0a1c4d8466efed6ef5971aa03a84ebb0836128b1/* .deps/build/src/treesitter/
```

# MSYS
- [Windows build error: error loading module 'nlua0' · Issue #23427 · neovim/neovim · GitHub](https://github.com/neovim/neovim/issues/23427)
- [mintty TUI · Issue #6751 · neovim/neovim · GitHub](https://github.com/neovim/neovim/issues/6751)
- [Neovim in Cygwin · GitHub](https://gist.github.com/equalsraf/efa3337718cd973de5713c3a84b10fc7)

## luajit ではなく lua を使う

`PREFER_LUA`
```sh
> cmake -S . -B build -G Ninja -DPREFER_LUA=on
```


## nlua0.dll
### link に失敗する
`-l が無い`

lua link
```cmake
# src\nvim\CMakeLists.txt
target_link_libraries(nlua0 PRIVATE lua)
target_link_directories(nlua0 PRIVATE ${DEPS_PREFIX}/lib)
```

## code generate に失敗する

以下の lpeg 呼び出しが abort する。
```lua
local lpeg = vim.lpeg
local Cc = lpeg.Cc
Cc('error')
```

関数自体は終了して、後でクラッシュする。
```c
static int lp_constcapture (lua_State *L) {
}
```
#define LUA_USE_LINUX 1

# MinGW
msys2 を使って MinGW ビルドする。メンテされていて簡単にビルドできる。
- [WindowsでNeovimをBuild+Install(msys2編)](https://zenn.dev/gz/articles/3aff3cda89524b)

msys2 の unix path が解釈できない
- msys 上で `fagitive` とか `quickfix` などがうまく動かない。
