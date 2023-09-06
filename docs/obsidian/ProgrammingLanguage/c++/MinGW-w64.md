
[MinGW-w64](https://www.mingw-w64.org/)

- [Releases · mstorsjo/llvm-mingw](https://github.com/mstorsjo/llvm-mingw/releases)

> forked it in 2007

# Version
## 11
## 10

# Structure
コンパイラー(gcc)とライブラリー(header/lib)の２部
## Tools
- [MinGW-w64クロスコンパイラ - Qiita](https://qiita.com/notunusualtales/items/6a4bf96a9f4e946aebc3)

## Library


# Cross
## WSL
- [ArchWSL と yay 及び Mingw-w64 を用いて MSYS2 風 Windows アプリケーション開発環境を構築する - Qiita](https://qiita.com/EarthSimilarityIndex/items/38c854b009b22d143b0b)

# runtime
[[runtime]]
-   libstdc++-6.dll
-   libwinpthread-1.dll
-   libgcc_s_seh-1.dll
`-static -lstdc++ -lgcc -lwinpthread` => `static リンク`
`-static-libgcc`、`-static-libstdc++`

# Win32API
独自にヘッダーを配布している。
[[win32]]

# CRuntime
## msvcrt
[[msvcrt]]

## ucrt
[[ucrt]]


# windres
mingw64-binutils
