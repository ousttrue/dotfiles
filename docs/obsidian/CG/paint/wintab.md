wintab
http://wdnet.jp/library/windows/wintab
http://wdnet.jp/library/windows/wacomwindevfaq

https://herm.azurewebsites.net/Localize/WinTab/

[* サンプル]
	https://gist.github.com/t-mat/54f05cfdccca07bcf99a0f2afbc5d466

code:CMakeLists.txt
 project(sample)
 cmake_minimum_required(VERSION 3.13.0)
 
 add_executable(sample WIN32
     WintabTest.cpp
     )

[* articles]
	[wintabから傾きを取得するコード https://waura.github.io/201012241293217750.html]
	[タブレットからペンの入力を受信する https://kondoumh.com/pgtips/wintab.html]

