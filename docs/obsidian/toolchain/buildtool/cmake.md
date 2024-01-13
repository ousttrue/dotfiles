[An Introduction to Modern CMake · Modern CMake](https://cliutils.gitlab.io/modern-cmake/)

# CMakeKits
[[cmake_kits]]

```
cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Release
```

# Version
## 3.25

# toolchain
- [CMAKE_TOOLCHAIN_FILE — CMake 3.25.0 Documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_TOOLCHAIN_FILE.html)
- [cmake-toolchains(7) — CMake 3.25.0 Documentation](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html)

## android NDK
```
DCMAKE_TOOLCHAIN_FILE=D:\\AndroidSdk\\ndk\\21.4.7075529\\build\\cmake\\android.toolchain.cmake`
```

## msvc
- [CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION — CMake 3.27.4 Documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION.html)

# fetch content
`3.11`
- [FetchContent — CMake 3.25.1 Documentation](https://cmake.org/cmake/help/latest/module/FetchContent.html)
- @2021 [cmakeでHeader Onlyライブラリをお手軽に使う - toge's diary](https://toge.hatenablog.com/entry/2021/01/27/150632)

## FetchContent_Populate

# cmake UWP build

[* cmake version 3.11.18040201-MSVC_2]
`C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe`

`cmake -G "Visual Studio 15 2017" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0 ..`

code:cmd
	CMake Error at CMakeLists.txt:7 (PROJECT):
 	 Visual Studio 15 2017 supports Windows Store '8.0', '8.1' and '10.0', but
  	not '10'.  Check CMAKE_SYSTEM_VERSION.

workaround
`10.0`ではなく`10.0.`を指定するのだ。
	http://www.itkeyword.com/doc/2131856565554565x907/how-can-i-use-cmake-to-generate-windows-10-universal-project

`cmake -G "Visual Studio 15 2017" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0. ..`

code:CmakeLists.txt
	CMAKE_MINIMUM_REQUIRED(VERSION 3.4)
	IF(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    SET(CMAKE_SYSTEM_VERSION "10.0")
	ENDIF()

もしくは、
`10.0.14393.0`とSDKバージョンを省略せずに記入する。
`10.0.`自動で最新版を選択する。

# configure_file
[[meson]]

# Find
[cmakeでfind_packageライクに自作ライブラリ有無をチェックしたりしたい、そんな時にはfind_package_handle_standard_argsが使える - Qiita](https://qiita.com/developer-kikikaikai/items/c357706121b3cd9051fe)

# ExternalProject
[ExternalProject — CMake 3.27.3 Documentation](https://cmake.org/cmake/help/latest/module/ExternalProject.html)
- @2019 [CMakeのExternalProjectで外部プロジェクトのビルドシステムに環境変数を渡す - 低レイヤ強くなりたい組込み屋さんのブログ](https://tomo-wait-for-it-yuki.hatenablog.com/entry/2019/03/24/050000)
- @2015 [CMake ExternalProject 事始め - Qiita](https://qiita.com/trairia/items/d20860d61f0e1eb2fb72)


