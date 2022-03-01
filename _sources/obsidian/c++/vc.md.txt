vcruntime
`Microsoft Visual Studio\2017\edition\VC\Tools\MSVC\lib-version\include`
`C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include\vcruntime.h`

https://docs.microsoft.com/en-us/cpp/porting/upgrade-your-code-to-the-universal-crt?view=vs-2019
https://devblogs.microsoft.com/cppblog/introducing-the-universal-crt/


$runtime="C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.26.28801\include";
$kits="C:\Program Files (x86)\Windows Kits\10\Include\10.0.18362.0";
$env:INCLUDE ="${runtime};${kits}\ucrt;${kits}\shared;${kits}\um";
