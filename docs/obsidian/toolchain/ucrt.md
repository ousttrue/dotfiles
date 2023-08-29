---
aliases: [WindowsKits]
---

[[runtime]] [[MinGW-w64]]

`C:\Program Files (x86)\Windows Kits\10`

> `vcruntime.h` への依存があり `MSVC` への依存がある。

単体でインストールしてもあまり使い道が無いので、`VC` のインストーラー経由で入れるとよい。

- [Universal CRT deployment | Microsoft Learn](https://learn.microsoft.com/en-us/cpp/windows/universal-crt-deployment?view=msvc-170)
- [Windows での汎用の C ランタイムの更新プログラム - Microsoft サポート](https://support.microsoft.com/ja-jp/topic/windows-%E3%81%A7%E3%81%AE%E6%B1%8E%E7%94%A8%E3%81%AE-c-%E3%83%A9%E3%83%B3%E3%82%BF%E3%82%A4%E3%83%A0%E3%81%AE%E6%9B%B4%E6%96%B0%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0-c0514201-7fe6-95a3-b0a5-287930f3560c)
- [Universal CRT へのコードのアップグレード | Microsoft Learn](https://learn.microsoft.com/ja-jp/cpp/porting/upgrade-your-code-to-the-universal-crt?view=msvc-170)

- @2021 [msys2でucrtのランタイムを使おう！ようこそucrt64 - Qiita](https://qiita.com/yumetodo/items/d849a6dcf08e0435f815)
- @2020 [C/C++ developer からみた uCRT のメモ - Qiita](https://qiita.com/syoyo/items/198f91b31c49c5ba68bb)

# Version
[Windows SDK とエミュレーターのアーカイブ | Microsoft Developer](https://developer.microsoft.com/ja-jp/windows/downloads/sdk-archive/)

## Windows10
システムコンポーネントとして標準インストール

## VC2015
Universal CRT 導入

# cmake

- [cmake-modules/FindWindowsSDK.cmake at main · rpavlik/cmake-modules · GitHub](https://github.com/rpavlik/cmake-modules/blob/main/FindWindowsSDK.cmake)

- [CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION — CMake 3.27.4 Documentation](https://cmake.org/cmake/help/latest/variable/CMAKE_VS_WINDOWS_TARGET_PLATFORM_VERSION.html)

# msys2 / mingw
- [MinGW 環境で UCRT(Universal CRT) ライブラリを使って C アプリをビルドするメモ - Qiita](https://qiita.com/syoyo/items/ad14912c983da94ad16e)
- [universal crt - How do I build against the UCRT with mingw-w64? - Stack Overflow](https://stackoverflow.com/questions/57528555/how-do-i-build-against-the-ucrt-with-mingw-w64)

# clang
- [GitHub - mstorsjo/llvm-mingw: An LLVM/Clang/LLD based mingw-w64 toolchain](https://github.com/mstorsjo/llvm-mingw)
## checked clang
- [Checked C clang の環境を用意する](https://zenn.dev/saitoyutaka/articles/ffd7b247026a82)

