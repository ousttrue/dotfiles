---
aliases: [msvc]
---
[[cpp]] [[ifdef]]

# version
[Visual C++のバージョン](https://so-zou.jp/software/tech/tool/ide/visual-cpp/introduction/version.htm)

## 2022 17
`c++23` `std::expected`
- [Download Visual Studio Tools - Install Free for Windows, Mac, Linux](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)
- `msvc-14.3`

## 2019 16
`c++20`
## 2017 15
`c++17` ?

# define
[Using the Windows Headers - Win32 apps | Microsoft Learn](https://learn.microsoft.com/en-us/windows/win32/winprog/using-the-windows-headers#faster-builds-with-smaller-header-files)

```c++
#define WINDOWS_LEAN_AND_MEAN
```

# vcruntime
`Microsoft Visual Studio\2017\edition\VC\Tools\MSVC\lib-version\include`
`C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include\vcruntime.h`

- [Upgrade your code to the Universal CRT | Microsoft Learn](https://docs.microsoft.com/en-us/cpp/porting/upgrade-your-code-to-the-universal-crt?view=vs-2019)
https://devblogs.microsoft.com/cppblog/introducing-the-universal-crt/

$runtime="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include";
$kits="C:\Program Files (x86)\Windows Kits\10\Include\10.0.18362.0";vc
$env:INCLUDE ="${runtime};${kits}\ucrt;${kits}\shared;${kits}\um";

# vc

```dos title="vcargs.bat"
@echo off
set INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE;C:\Program Files (x86)\Windows Kits\10\include\10.0.10240.0\ucrt
set LIB=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\LIB\amd64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.10240.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\8.1\lib\winv6.3\um\x64
set PATH=C:\LLVM\bin;%PATH%
set UCRTContentRoot=C:\Program Files (x86)\Windows Kits\10\
set UCRTVersion=10.0.10240.0
set UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\
```

