[[cmake]]
[[nvim_msys2]]
# deps
`cmake.deps/CMakeLists.txt` による依存ライブラリの構築 

```sh
cmake -S cmake.deps -B .deps
```

と呼び出して `.deps` にビルドする。

## DEPS_INSTALL_DIR
- `.deps/usr` が本体構築時に `${DEPS_PREFIX}`  として参照される。

## cmake/Deps.cmake
```cmake
include(Deps)
```

```cmake
set(DEPS_INSTALL_DIR "${CMAKE_BINARY_DIR}/usr")
```

## ExternalProject
[ExternalProject — CMake 3.27.3 Documentation](https://cmake.org/cmake/help/latest/module/ExternalProject.html)
- @2019 [CMakeのExternalProjectで外部プロジェクトのビルドシステムに環境変数を渡す - 低レイヤ強くなりたい組込み屋さんのブログ](https://tomo-wait-for-it-yuki.hatenablog.com/entry/2019/03/24/050000)
- @2015 [CMake ExternalProject 事始め - Qiita](https://qiita.com/trairia/items/d20860d61f0e1eb2fb72)

# mingw
```
> D:/msys64/usr/bin/ls  build/mingw/bin
cat.exe  libiconv-2.dll  libintl-8.dll  lua51.dll  nvim.exe  platforms  tee.exe  win32yank.exe  xxd.exe
```

# llvm-mingw
## luajit
内部ビルドが失敗するので、meson で外部ビルドする。
[[luajit]]
- LLVM-MInGW(ucrt) + meson でできた https://github.com/franko/luajit

## gettext
内部ビルドが失敗するので、meson で外部ビルドする。

## iconv
内部ビルドが失敗するので、meson で外部ビルドする。
