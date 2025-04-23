[コンパイラ・C++ 標準の判定 · GitHub](https://gist.github.com/treastrain/483a2d233560dc99fda8e59b6fd03361)

- [低レイヤを知りたい人のためのCコンパイラ作成入門](https://www.sigbus.info/compilerbook)

# MSVC

## msvcrt

## ucrt

# Clang

## zapcc

- [高速C++コンパイラZapccの試行(2. GCC / LLVM / zapcc でのコンパイル速度比較) - FPGA開発日記](https://msyksphinz.hatenablog.com/entry/2018/06/29/040000)

## zig cc

## WindowsKits

[[ucrt|WindowsKits]]

- [ClangOnWindows/build.bat at master · Leandros/ClangOnWindows · GitHub](https://github.com/Leandros/ClangOnWindows/blob/master/build.bat)

## MinGW

- [GitHub - mstorsjo/llvm-mingw: An LLVM/Clang/LLD based mingw-w64 toolchain](https://github.com/mstorsjo/llvm-mingw)
  `msvcrt`, `ucrt` 両方ある

### msvcrt

本家の prebuilt はこれぽい。

### ucrt

```
> ldd build\hello.exe
ntdll.dll
KERNEL32.DLL
KERNELBASE.dll
ucrtbase.dll => ucrt
libc++.dll => clang
libunwind.dll => clang
```

# MinGW

## msvcrt

- @2018 [msys2とC++で特定のDLLに依存しないwindowsバイナリを作る - siunのメモ](https://siuncyclone.hatenablog.com/entry/2018/07/21/194629)

```
libstdc++-6.dll
libwinpthread-1.dll
libgcc_s_seh-1.dll
```

## ucrt

```
> ldd build\hello.exe
ntdll.dll => /c/WINDOWS/SYSTEM32/ntdll.dll (0x7ffc58bf0000)
KERNEL32.DLL => /c/WINDOWS/System32/KERNEL32.DLL (0x7ffc57b80000)
KERNELBASE.dll => /c/WINDOWS/System32/KERNELBASE.dll (0x7ffc56070000)
ucrtbase.dll => /c/WINDOWS/System32/ucrtbase.dll (0x7ffc56600000)
libgcc_s_seh-1.dll => /ucrt64/bin/libgcc_s_seh-1.dll (0x7ffc452d0000)
libwinpthread-1.dll => /ucrt64/bin/libwinpthread-1.dll (0x7ffc451d0000)
libstdc++-6.dll => /ucrt64/bin/libstdc++-6.dll (0x7ffc1f000000)
```
