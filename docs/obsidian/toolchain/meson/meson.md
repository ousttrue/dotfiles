[Fetching Title#7bn3](https://gitlab.freedesktop.org/xrdesktop/xrdesktop)[[buildtool]]
[[gst-python]]

- @2022 [Meson で subproject のオプションを指定する方法 - チラシの表の反対側](https://www.kofuk.org/blog/20221231-meson-options/)

- @2020 [bitWalk's: Vala と Meson とクロスコンパイル](https://bitwalk.blogspot.com/2020/08/vala-meson.html)
- @2019 [［Meson］Meson for C++の苦闘記 - 地面を見下ろす少年の足蹴にされる私](https://onihusube.hatenablog.com/entry/2019/09/20/023511)

# reference

- [Reference manual](https://mesonbuild.com/Reference-manual.html)

# usage

## project

- [project](https://mesonbuild.com/Reference-manual_functions.html#project)

```meson.build
project('helloworld', 'c')
```

### default_options

大域設定

- cpp_std=c++20
- cpp_args=/utf-8
- c_args=/utf-8

### default_options

```meson.build
project( 'calculator', 'cpp', default_options: ['warning_level=3'])
```

```meson.build
project('test_project', 'cpp', default_options : ['warning_level=3', 'werror=true', 'cpp_std=c++17'], meson_version : '>=0.50.0')
```

## executable

```meson.build
executable('hello', 'hello.c')
```

```meson.build
program(
    'calculator', ['main.cpp'],
    include_directories: includes,
    link_with: perfectcalc_lib)
```

## library

```meson.build
perfectcalc_lib = library(
    'perfectcalc', ['plus.cpp'],
    include_directories: includes)
```

### static

`static_library`

### shared

### 設定でスイッチするには？

## compile options

### c++

`c++17`

### include_directories

```meson.build
includes = include_directories('include')

include_dir = include_directories('include', 'oher/include')

# -isystem. system header の警告抑制？
include_directories('path/to/include', is_system: true)
```

### definitions

### compiler

```meson.build
cppcompiler = meson.get_compiler('cpp').get_argument_syntax()

if cppcompiler == 'msvc'
    # MSVC,clang-cl,icc(windows)用
    options = ['/std:c++latest']
elif cppcompiler == 'gcc'
    # gcc,clang,icc(linux)用
    options = ['-std=c++2a']
else
    # その他
    options = []
endif

include_dir = include_directories('include', 'oher/include')
executable('test_project', 'test.cpp', include_directories : include_dir, cpp_args : options)
```

## link options

### lib_directories

### libs

## install options

dll lib or bin ?

## message

```meson.build
flag=false
message(flag)
message('b_asneeded: ', get_option('b_asneeded'))
```

# target dependencies

## subproject

- [Subprojects](https://mesonbuild.com/Subprojects.html)

```meson.build
doctest_proj = subproject('doctest')
doctest_dep = doctest_proj.get_variable('doctest_dep')
```

## cmake subproject

- [meson で cmake プロジェクトを subproject として使う - Qiita](https://qiita.com/syoyo/items/ad965b5127188c356074)

## dependency

```meson.build
lua_dep = dependency('lua')
```

### method

- pkg-config, cmake, ...

### declara_dependency

- [declaring](https://mesonbuild.com/Dependencies.html#declaring-your-own)
  pango

```meson
libpango_dep = meson.declare_dependency()
meson.override_dependency('pango', libpango_dep)
```

### force subproject

- [How to force meson to use only wrap subproject - Stack Overflow](https://stackoverflow.com/questions/73053163/how-to-force-meson-to-use-only-wrap-subproject)

## subproject override

## wrap dependency system

- [Wrap dependency system manual](https://mesonbuild.com/Wrap-dependency-system-manual.html)
- [Meson WrapDB packages](https://mesonbuild.com/Wrapdb-projects.html)

# native-file

cmake の toochain に相当

- @2022 [Mesonの使い方メモ - はしくれエンジニアもどきのメモ](https://cartman0.hatenablog.com/entry/2022/03/24/Meson%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%83%A1%E3%83%A2)

## default の native-file を固定するべし

mingw の `ld.exe` に `PATH` が通って link が失敗する状況があった。

# module

`import`

- @2022 [Mesonを使ってGObject Introspection対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)

# meson のコード

## entry_point

`mesonbuild.mesonmain:main`

## vscode launch

```json
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "meson",
      "type": "python",
      "request": "launch",
      "module": "mesonbuild.mesonmain",
      "args": ["compile", "-C", "build"],
      "cwd": "${workspaceFolder}",
      "justMyCode": false
    }
  ]
}
```

# configure_file

[Configuration](https://mesonbuild.com/Configuration.html)

# subprojects

git

`.git/config`

```
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
	remote = origin
	merge = refs/heads/master
```

# detect compiler

```
meson.build:1:0: ERROR: Unknown compiler(s): [['icl'], ['cl'], ['cc'], ['gcc'], ['clang'], ['clang-cl'], ['pgcc']]
```
