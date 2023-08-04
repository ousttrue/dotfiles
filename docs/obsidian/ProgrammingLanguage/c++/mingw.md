
[MinGW-w64](https://www.mingw-w64.org/)

# Version
## mingw-w64 10.0.0

# WSL
- [ArchWSL と yay 及び Mingw-w64 を用いて MSYS2 風 Windows アプリケーション開発環境を構築する - Qiita](https://qiita.com/EarthSimilarityIndex/items/38c854b009b22d143b0b)
# runtime
[[runtime]]
-   libstdc++-6.dll
-   libwinpthread-1.dll
-   libgcc_s_seh-1.dll
`-static -lstdc++ -lgcc -lwinpthread` => `static リンク`
`-static-libgcc`、`-static-libstdc++`
