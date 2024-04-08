- [Open Source Development | Open Source License | Qt](https://www.qt.io/download-open-source)
- [Index of /](https://download.qt.io/)
- https://doc.qt.io/qt-6/qtmodules.html

# version

## 6.7 @202407

- [Qt 6.7 リリース](https://www.qt.io/ja-jp/blog/qt-6.7-released)
- https://doc.qt.io/qt-6/windows-building.html

## 6.5 LTS

- [Qt 6.5 Release - Qt Wiki](https://wiki.qt.io/Qt_6.5_Release)
- [Qt 6.5 Beta Released](https://www.qt.io/blog/qt-6.5-beta-released)
- [Building Qt 6 from Git - Qt Wiki](https://wiki.qt.io/Building_Qt_6_from_Git)
  > Perl (**>=5.14**, optional for Qt **>= 6.5**)

## 6.4

- @2022 [Qt 6.4 がリリースされました](https://www.qt.io/ja-jp/blog/qt-6.4-released)
- [Qt6 module](https://mesonbuild.com/Qt6-module.html)
- [Qt for Windows - Building from Source | Qt 6.4](https://doc.qt.io/qt-6/windows-building.html)
- [Index of /official_releases/qt/6.4/6.4.2/single](https://download.qt.io/official_releases/qt/6.4/6.4.2/single/)

## 6.2

- @2021 [Qt 6.2 LTSをリリースしました！](https://www.qt.io/ja-jp/blog/qt-6.2-lts-released)

## 6.0

- @2019 [Qt 6 の技術的なビジョン | Qt の未来は明るいブログ](https://qt5.jp/2019/08/technical-vision-qt-6/)

## 5

- @2019 [Qt のあれこれ (仮) &#8211; Qt のあれこれ (仮)](https://qt-labs.jp/)

# Use

## from cmake

- [Getting started with CMake | Build with CMake 6.4.2](https://doc.qt.io/qt-6/cmake-get-started.html)
  `CMAKE_INSTALL_PREFIX=VCPKG_DIR/installed/x64-windows`
- @2022 [qmakeからcmakeへの移行(挫折)](https://zenn.dev/false/articles/0008-afff49ea408815)

```cmake
cmake_minimum_required(VERSION 3.16)

project(helloworld VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets)
qt_standard_project_setup()

add_executable(helloworld
    main.cpp
)

target_link_libraries(helloworld PRIVATE Qt6::Core Qt6::Widgets)
```

## from meson

- [GitHub - Neumann-A/meson-vcpkg: Example to run vcpkg from within meson](https://github.com/Neumann-A/meson-vcpkg)

# QPA

`Qt Platform Abstraction`

- [Qt Platform Abstraction | Platform Integration 6.4.2](https://doc.qt.io/qt-6/qpa.html)
- @2014 [QPA(Qt Platform Abstraction) メモ - Qiita](https://qiita.com/maueki/items/7f9bec409c880550a0d3)
- @2012 [QPA のお勉強(1) | Qt の未来は明るいブログ](https://qt5.jp/2012/12/learn-qpa-01/)
- [GitHub - jhihn/Vaudeville: Qt Backend for HTML5 Canvas (Via QPA eventually)](https://github.com/jhihn/Vaudeville)
- [GitHub - nowrep/qpa-headlessegl: Qt platform plugin - headlessegl](https://github.com/nowrep/qpa-headlessegl)
- [GitHub - uwerat/qpagbm: A Qt platform plugin for running Qt/OpenGL applications offscreen](https://github.com/uwerat/qpagbm)
- [GitHub - mnutt/qt-phantom-platform-plugin: Qt qpa plugin for running headless apps, with font support (extracted from phantomjs)](https://github.com/mnutt/qt-phantom-platform-plugin)
- [GitHub - jkriege2/cairoQPaintDevice: library for Qt: QPaintDevice implementation that uses Cairo as a backend (e.g. for high-quality PDF/EPS/PNG/SVG output!)](https://github.com/jkriege2/cairoQPaintDevice)

## VNC

- [Qt アプリを VNC サーバーとして実行する | Qt の未来は明るいブログ](https://qt5.jp/2021/10/qpa-vnc/)

# sample

- https://github.com/PacktPublishing/Cross-Platform-Development-with-Qt-6-and-Modern-Cpp
