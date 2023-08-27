# meson
[[meson]]

# cross compile
- [WSL2 Ubuntu 20.04でWindows用のバイナリをクロスコンパイルしたい](https://zenn.dev/quasar/scraps/b23f0cd306318f)

# Ubuntu

```
sudo apt install clang libc++-dev
```

# Arch

```
sudo pacman -S clang lld libc++
```




# clang-cl
[MSVC compatibility — Clang 18.0.0git documentation](https://clang.llvm.org/docs/MSVCCompatibility.html)
`clang-cl.exe == clang.exe --driver-mode=cl`

- [Visual Studio C++ Build Tools + clang-cl + CMake + Ninja で C++ バッチビルドや VSCode 連携環境を整える - Qiita](https://qiita.com/syoyo/items/bd4f81e7803afb5a3d19)
- [tinyusdz/bootstrap-clang-cl-win64.bat at release · syoyo/tinyusdz · GitHub](https://github.com/syoyo/tinyusdz/blob/release/bootstrap-clang-cl-win64.bat)

- WindowsKits 必要
- VC 必要？

## msvcrt
```
cmd.exe /C "cd . && C:\PROGRA~1\LLVM\bin\clang.exe -fuse-ld=lld-link -nostartfiles -nostdlib -O0 -g -Xclang -gcodeview -D_DEBUG -D_DLL -D_MT -Xclang --dependent-lib=msvcrtd -Xlinker /subsystem:console CMakeFiles/cmTC_8eea1.dir/testCCompiler.c.obj -o cmTC_8eea1.exe -Xlinker /MANIFEST:EMBED -Xlinker /implib:cmTC_8eea1.lib -Xlinker /pdb:cmTC_8eea1.pdb -Xlinker /version:0.0
 -lkernel32 -luser32 -lgdi32 -lwinspool -lshell32 -lole32 -loleaut32 -luuid -lcomdlg32 -ladvapi32 -loldnames
```

## ucrt
