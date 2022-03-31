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

