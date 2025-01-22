https://github.com/luarocks/luarocks/wiki/Creating-a-rock#writing-a-rockspec

- @2018 [LuaRocksにモジュールを登録する方法 - 2018-11-19 - ククログ](https://www.clear-code.com/blog/2018/11/19.html)
- @2020 [发布你第一个 Luarocks 包 | TripleZ's Blog](https://blog.triplez.cn/posts/publish-your-first-luarocks-package/)
- @2014 [LuaRocks で Lua のモジュールを管理する #GitHub - Qiita](https://qiita.com/mah0x211/items/a07a2628f129285a9337)
- @2018 [LuaRocksに自作モジュールを登録する手順 #Lua - Qiita](https://qiita.com/toritori0318/items/fdd2c92caba2c003a51d)
- @2020 [LuaRocksのrockspecの更新を楽にする](https://zenn.dev/notomo/articles/luarocks-rockspec-easy-update)

# Build back-ends

https://github.com/luarocks/luarocks/wiki/Rockspec-format

## builtin

- https://github.com/lunarmodules/luafilesystem/blob/master/luafilesystem-scm-1.rockspec
- https://github.com/lunarmodules/busted/blob/master/busted-scm-1.rockspec
- https://luarocks.org/manifests/xavier-wang/glfw-0.1.2-1.rockspec

## cmake

- https://github.com/luvit/luv/blob/master/luv-scm-0.rockspec
- https://github.com/slages/love-imgui/blob/master/love-imgui-scm-1.rockspec
- https://github.com/effil/effil/blob/ef93c6a2a8b25efff85b6d4eef48811f569375ee/rockspecs/effil-1.1-0.rockspec#L25

```lua
package = "megasource"
version = "dev-1"
source = {
  -- url = "git+https://github.com/love2d/megasource"
  url = "...",
}
description = {
  summary = "It is currently only officially supported on Windows, but may also work on macOS.",
  detailed =
  "It is currently only officially supported on Windows, but may also work on macOS. It could certainly also work on Linux, but good package managers makes megasource less relevant there.",
  homepage = "https://github.com/love2d/megasource",
  license = "*** please specify a license ***",
}
build = {
  type = "cmake",
  variables = {
    -- find_package (LuaJIT)
    LUA_LIBDIR = "$(LUA_LIBDIR)",
    LUA_INCDIR = "$(LUA_INCDIR)",
    LUA_LIBFILE = "$(LUALIB)",
    LUAJIT_DIR = "$(LUA_DIR)",
    LUA = "$(LUA)",
    -- install destination
    CMAKE_INSTALL_PREFIX = "prefix",
    -- CMAKE_INSTALL_PREFIX = "$(LIBDIR)",
  },
  install = {
    lib = {
      "prefix/love.dll",
    },
    bin = {
      "prefix/OpenAL32.dll",
      "prefix/SDL3.dll",
    },
  },
}```

## command

- https://github.com/VisionLabs/torch-opencv/blob/389fe4f029ef790b4ed22b1ac7abef3f210ebc0f/cv-scm-1.rockspec#L25
