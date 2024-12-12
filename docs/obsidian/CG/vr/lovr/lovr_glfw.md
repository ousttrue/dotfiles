[[lovr]]

> desktop mode

# dll buid 実験

```sh
> cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -DLOVR_BUILD_SHARED=ON -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DLUAJIT_BUILD_TOOL=1
> cmake --build build
> cmake --install build --prefix $(pwd)/prefix
```

というより Android 版がこれを使う。
Android 版の entry point を見るべし。

`src/os_android.c`
👇
`src/main.c`

`src/os_win32.c`
👇
`src/main.c`

下記で起動できる？

```sh
> lua.exe etc/boot.lua
```

`lovr.dll` に `luaopen_lovr` が含まれていなかった
👇
`src/api/l_lovr.c`

```c
L#define LOVR_EXPORT __declspec(dllexport)
OVR_EXPORT int luaopen_lovr(lua_State *L)
```

luajit.exe 作る

```cmake
# set_target_properties(luajit PROPERTIES EXCLUDE_FROM_ALL 1)
```

👇
`build/luajit/src/luajit.exe`

```
LUA_CPATH=build\\?.dll build/luajit etc\boot.lua
```

エラーにはならんが、まだ動かぬ
