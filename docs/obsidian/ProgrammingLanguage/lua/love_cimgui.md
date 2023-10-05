
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
