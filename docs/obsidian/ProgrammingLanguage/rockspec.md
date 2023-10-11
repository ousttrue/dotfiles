[[luarocks]]

[Creating a rock · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Creating-a-rock#using-luarocks-as-a-build-system)

- @2018 [LuaRocksにモジュールを登録する方法 - 2018-11-19 - ククログ](https://www.clear-code.com/blog/2018/11/19.html)

```lua
package = "LuaFruits"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "An example for the LuaRocks tutorial.",
   detailed = [[
      This is an example for the LuaRocks tutorial.
      Here we would put a detailed, typically
      paragraph-long description.
   ]],
   homepage = "http://...", -- We don't have one yet
   license = "MIT/X11" -- or whatever you like
}
dependencies = {
   "lua >= 5.1, < 5.4"
   -- If you depend on other rocks, add them here
}
build = {
   -- We'll start here.
}
```

# template
```
$ luarocks write_rockspec
```
`${package}-${version}.rockspec`
```lua
package = "lvrm"
version = "dev-1"
build = {
}
```

# format
[Rockspec format · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Rockspec-format)

# build.type
[Rockspec format · luarocks/luarocks Wiki · GitHub](https://github.com/luarocks/luarocks/wiki/Rockspec-format#build-back-ends)
## builtin

## cmake
## make
## command
