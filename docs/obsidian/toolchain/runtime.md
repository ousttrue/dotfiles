[[compiler]]

# CRuntime
- @2022 [llvm-mingw msvcrt, ucrt のメモ - Qiita](https://qiita.com/syoyo/items/36935d8231c6ebd41262)
## MSVCRT
VCに付属する
[[msvcrt]]
`-lmsvcrt` to `-lvcruntime140 -lucrt`

## UCRT
Windows10以降、OS([[WindowsKits]])に付属する
[[ucrt]]

vc のヘッダに依存しているので、何れかの vc のインストールも必要
```c
#include <vcruntime.h>
```

## cygwin
### cygwin
`cygwin1.dll`
`-mno-cygwin` => `msvcrt`
👇

### msys
👇

### msys2
`msys-2.0.dll`
[[msys2]]

# C++Runtime
- [C++17と標準ライブラリ: C++17を使うときに気をつけたいこと - molecular coordinates](https://coordination.hatenablog.com/entry/2019/01/19/213639)
## libstdc++
### static
- [static-libstdc++](https://jp.xlsoft.com/documents/intel/compiler/18/cpp_18_win_lin/GUID-9F52B56B-903D-473E-92E1-3096723B22F3.html)
- [静的にlibstdc++をリンクする - futada diary](https://futada.hatenadiary.org/entry/20111218/1324218410)

## libc++

# ExceptionRuntime ?
## libgcc_s

## libunwind
- [libunwind LLVM Unwinder — libunwind 8.0 documentation](https://bcain-llvm.readthedocs.io/projects/libunwind/en/latest/)
- [The libunwind project](https://www.nongnu.org/libunwind/)
- [Ubuntu で clang + libc++ を使う - Qiita](https://qiita.com/kojiohta/items/fb6c307365d1db388acc)

### static
- [Alpine Linux packages](https://pkgs.alpinelinux.org/package/edge/main/x86/libunwind-static)

# Win32API
## VC
[[msvcrt]]

## WindowsKits
[[ucrt]]

## MinGW-w64
[[MinGW-w64]]
`Windows.h` などを提供する代替実装。
