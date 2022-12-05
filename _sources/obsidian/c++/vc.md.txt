vcruntime
`Microsoft Visual Studio\2017\edition\VC\Tools\MSVC\lib-version\include`
`C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include\vcruntime.h`

https://docs.microsoft.com/en-us/cpp/porting/upgrade-your-code-to-the-universal-crt?view=vs-2019
https://devblogs.microsoft.com/cppblog/introducing-the-universal-crt/


$runtime="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include";
$kits="C:\Program Files (x86)\Windows Kits\10\Include\10.0.18362.0";
$env:INCLUDE ="${runtime};${kits}\ucrt;${kits}\shared;${kits}\um";


vc
#visualstudio

code:vcargs.bat
 @echo off
 set INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\INCLUDE;C:\Program Files (x86)\Windows Kits\10\include\10.0.10240.0\ucrt
 set LIB=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\LIB\amd64;C:\Program Files (x86)\Windows Kits\10\lib\10.0.10240.0\ucrt\x64;C:\Program Files (x86)\Windows Kits\8.1\lib\winv6.3\um\x64
 set PATH=C:\LLVM\bin;%PATH%
 set UCRTContentRoot=C:\Program Files (x86)\Windows Kits\10\
 set UCRTVersion=10.0.10240.0
 set UniversalCRTSdkDir=C:\Program Files (x86)\Windows Kits\10\
 set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\

