cmake UWP build
#cmake
#UWP
[* cmake version 3.11.18040201-MSVC_2]
`C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe`

`cmake -G "Visual Studio 15 2017" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0 ..`

code:cmd
	CMake Error at CMakeLists.txt:7 (PROJECT):
 	 Visual Studio 15 2017 supports Windows Store '8.0', '8.1' and '10.0', but
  	not '10'.  Check CMAKE_SYSTEM_VERSION.

workaround
`10.0`ではなく`10.0.`を指定するのだ。
	http://www.itkeyword.com/doc/2131856565554565x907/how-can-i-use-cmake-to-generate-windows-10-universal-project

`cmake -G "Visual Studio 15 2017" -DCMAKE_SYSTEM_NAME=WindowsStore -DCMAKE_SYSTEM_VERSION=10.0. ..`

code:CmakeLists.txt
	CMAKE_MINIMUM_REQUIRED(VERSION 3.4)
	IF(CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    SET(CMAKE_SYSTEM_VERSION "10.0")
	ENDIF()

もしくは、
`10.0.14393.0`とSDKバージョンを省略せずに記入する。
`10.0.`自動で最新版を選択する。
