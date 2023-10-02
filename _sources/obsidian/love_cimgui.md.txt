
internal を含むように生成。
```sh
> cd cimgui
cimgui> LUA_PATH=./?.lua D:/msys64/mingw64/bin/luajit generator.lua cl "internal"
cimgui> cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release
cimgui> cmake --build build
cimgui> ls build
build/cmake.dll
> LUA_PATH=./?.lua D:/msys64/mingw64/bin/luajit generator.lua
```
