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

# cygwin
`cygwin1.dll`
`-mno-cygwin` => `msvcrt`
👇

# msys
👇

# msys2
`msys-2.0.dll`
[[msys2]]

# MinGW-w64
[[mingw]]
`Windows.h` などを提供する代替実装。
