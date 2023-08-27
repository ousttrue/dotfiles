
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
ntdll.dll
KERNEL32.DLL
KERNELBASE.dll
ucrtbase.dll <= ucrt
msvcrt.dll <= msvcrt
libstdc++-6.dll <= gcc
libgcc_s_seh-1.dll <= gcc
```
