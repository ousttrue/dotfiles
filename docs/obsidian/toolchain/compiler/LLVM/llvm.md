[[mesa]]
[[clang]]
[[llvm-mingw]]

[Getting Started with the LLVM System — LLVM 17.0.0git documentation](https://llvm.org/docs/GettingStarted.html)

# Version

- [Clang - C++ Programming Language Status](https://clang.llvm.org/cxx_status.html)

## 19



## 18

- [Clang 18.0.0git (In-Progress) Release Notes — Clang 18.0.0git documentation](https://clang.llvm.org/docs/ReleaseNotes.html)

## 17

## 16

- [Clang 16.0.0 Release Notes — Clang 16.0.0 documentation](https://releases.llvm.org/16.0.0/tools/clang/docs/ReleaseNotes.html)

## 15

## 14

- @2022 [LLVM/Clang 14をビルドする - Qiita](https://qiita.com/k0kubun/items/4c29cf9cc423448ea59a)

## 12

- @2021 [Rust + LLVMでプログラミング言語を自作してセルフホスティングした話](https://zenn.dev/yubrot/articles/eaaeeab742b4a1)

## 8

- @2019 [こわくないLLVM入門！ - Qiita](https://qiita.com/Anko_9801/items/df4475fecbddd0d91ccc)
- @2017 [LLVMを始めよう！ 〜 LLVM IRの基礎はclangが教えてくれた・Brainf\*\*kコンパイラを作ってみよう 〜 - プログラムモグモグ](https://itchyny.hatenablog.com/entry/2017/02/27/100000)

## 7

- @2018 [LLVM builld - simotin13's message](http://mcommit.hatenadiary.com/entry/2018/01/05/025802)

## 3

- @2016 [OCamlのSedlex+Menhir+LLVMでLispコンパイラを作ろうとしたが行き詰まった件 - Qiita](https://qiita.com/Tamamu/items/e647c18403681df15c42)
- @2015 [LLVM + pythonでC++のAST生成メモ(Windows編).md · GitHub](https://gist.github.com/yoggy/34d5bc8a7993ba1242d0)

# Build

8core memory16GB SSD MSVC で90分くらい
8core memory16GB SSD msys2-MINGW64 で30くらいだが linker がこける
8core memory16GB SSD msys2-CLANG64 で15くらい

```
cmake -S . -B build -DLLVM_TARGETS_TO_BUILD=host -DLLVM_ENABLE_PROJECTS=lld;clang -DLLVM_ENABLE_DOXYGEN=off -DLLVM_ENABLE_SPHINX=off -DCMAKE_BUILD_TYPE=Rlease -DCMAKE_INSTALL_PREFIX=D:/llvm -G Ninja

-- The C compiler identification is MSVC 19.37.32822.0
-- The CXX compiler identification is MSVC 19.37.32822.0
-- The ASM compiler identification is MSVC
-- LLVM host triple: x86_64-pc-windows-msvc
-- LLVM default target triple: x86_64-pc-windows-msvc

-DLLVM_TARGETS_TO_BUILD=host
-DLLVM_ENABLE_DOXYGEN=off
-DLLVM_ENABLE_SPHINX=off


cmake --build build
[0/3946]... 40min? 1400
```

```
> D:/msys64/usr/bin/ldd D:/llvm-mingw/bin/clang.exe
        ntdll.dll => /c/WINDOWS/SYSTEM32/ntdll.dll (0x7ffdc1130000)
        KERNEL32.DLL => /c/WINDOWS/System32/KERNEL32.DLL (0x7ffdc0310000)
        KERNELBASE.dll => /c/WINDOWS/System32/KERNELBASE.dll (0x7ffdbe900000)
        ucrtbase.dll => /c/WINDOWS/System32/ucrtbase.dll (0x7ffdbe740000)
        SHELL32.dll => /c/WINDOWS/System32/SHELL32.dll (0x7ffdbf030000)
        msvcp_win.dll => /c/WINDOWS/System32/msvcp_win.dll (0x7ffdbe860000)
        USER32.dll => /c/WINDOWS/System32/USER32.dll (0x7ffdc0760000)
        win32u.dll => /c/WINDOWS/System32/win32u.dll (0x7ffdbecb0000)
        GDI32.dll => /c/WINDOWS/System32/GDI32.dll (0x7ffdc0660000)
        gdi32full.dll => /c/WINDOWS/System32/gdi32full.dll (0x7ffdbece0000)
        ole32.dll => /c/WINDOWS/System32/ole32.dll (0x7ffdbfa10000)
        combase.dll => /c/WINDOWS/System32/combase.dll (0x7ffdbfd60000)
        RPCRT4.dll => /c/WINDOWS/System32/RPCRT4.dll (0x7ffdc03e0000)
        ADVAPI32.dll => /c/WINDOWS/System32/ADVAPI32.dll (0x7ffdbf960000)
        msvcrt.dll => /c/WINDOWS/System32/msvcrt.dll (0x7ffdbfcb0000)
        sechost.dll => /c/WINDOWS/System32/sechost.dll (0x7ffdc0500000)
        libc++.dll => not found
        api-ms-win-crt-environment-l1-1-0.dll => not found
        api-ms-win-crt-heap-l1-1-0.dll => not found
        api-ms-win-crt-private-l1-1-0.dll => not found
        api-ms-win-crt-runtime-l1-1-0.dll => not found
        api-ms-win-crt-stdio-l1-1-0.dll => not found
        api-ms-win-crt-string-l1-1-0.dll => not found
        api-ms-win-crt-utility-l1-1-0.dll => not found
        api-ms-win-crt-convert-l1-1-0.dll => not found
        api-ms-win-crt-math-l1-1-0.dll => not found
        api-ms-win-crt-time-l1-1-0.dll => not found
        VERSION.dll => /c/WINDOWS/SYSTEM32/VERSION.dll (?)
        zlib1.dll => not found
        libzstd.dll => not found
```

## linker error: could not read symbols: Memory exhausted

[Compiling clang on a 32-bit system fails because of insufficient virtual memory - Stack Overflow](https://stackoverflow.com/questions/41144334/compiling-clang-on-a-32-bit-system-fails-because-of-insufficient-virtual-memory)

```
-Wl,--no-keep-memory -Wl,--reduce-memory-overheads
```

## LLVM_TARGETS_TO_BUILD

`host`
CPU ターゲット。クロスコンパイラ

## LLVM_DEFAULT_TARGET_TRIPLE

`x86_64-pc-windows-gnu`
`x86_64-pc-windows-msvc19`
`x86_64-pc-windows-msvc`
`x86_64-apple-darwin`

実行環境？

## ccls

```
cmake -S . -B build -DClang_DIR=D:/llvm/lib/cmake/clang
```

## zig

`zig-11` でビルドするには？

# Tutorial

- [LLVM Tutorial: Table of Contents — LLVM 16.0.0git documentation](https://llvm.org/docs/tutorial/)
