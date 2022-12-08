[Fetching Title#7bn3](https://gitlab.freedesktop.org/xrdesktop/xrdesktop)[[buildtool]]
[[gst-python]]

- [The Meson Build system](https://mesonbuild.com/)
- @2022 [Mesonを使ってGObject Introspection対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)
- @2022 [Mesonの使い方メモ - はしくれエンジニアもどきのメモ](https://cartman0.hatenablog.com/entry/2022/03/24/Meson%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9%E3%83%A1%E3%83%A2)
- @2019 [［Meson］Meson for C++の苦闘記 - 地面を見下ろす少年の足蹴にされる私](https://onihusube.hatenablog.com/entry/2019/09/20/023511)
- @2018 [CMakeの代替 (となってほしい)、Mesonチュートリアル - Qiita](https://qiita.com/turenar/items/c727834fbf701beb47ef)

# reference
- [Reference manual](https://mesonbuild.com/Reference-manual.html)

# python
## entry_point

`mesonbuild.mesonmain:main`

# dependency
- [Functions](https://mesonbuild.com/Reference-manual_functions.html#dependency)
- pkg-config
- cmake

```meson
some_dep = dependency('some')
```

## method
- pkg-config, cmake, ...

## fallback

## force subproject
- [How to force meson to use only wrap subproject - Stack Overflow](https://stackoverflow.com/questions/73053163/how-to-force-meson-to-use-only-wrap-subproject)

## subprojects
- [Subprojects](https://mesonbuild.com/Subprojects.html)

## wrap dependency system
- [Wrap dependency system manual](https://mesonbuild.com/Wrap-dependency-system-manual.html)
- [Meson WrapDB packages](https://mesonbuild.com/Wrapdb-projects.html)

## install先
dll lib or bin ?

## cmake subproject
- [meson で cmake プロジェクトを subproject として使う - Qiita](https://qiita.com/syoyo/items/ad965b5127188c356074)

## vscode debugger
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
            "args": [
                "compile",
                "-C",
                "build"
            ],
            "cwd": "${workspaceFolder}",
            "justMyCode": false
        },
    ]
}
```

## override_dependency

```
subprojects\pango\pango\meson.build:171:6: ERROR: Tried to override dependency 'pango' which has already been resolved or overridden at D:\ghq\github.com\GNOME\gtk\meson.build:391:
```

`mesonbuild/interpreter/mesonmain.py`
```python
# comment out
383         if override:
384             if permissive:
385                 return
386             m = 'Tried to override dependency {!r} which has already been resolved or overridden at {}'
387             location = mlog.get_error_location_string(override.node.filename, override.node.lineno)
388             raise InterpreterException(m.format(name, location))
```
gtk
```
pango_dep      = dependency('pango', version: pango_req,
                            fallback : ['pango', 'libpango_dep'])

pangocairo_dep = dependency('pangocairo', version: pango_req,
                            fallback : ['pango', 'libpangocairo_dep'])				
```

pango
```meson
libpango_dep = meson.declare_dependency()
meson.override_dependency('pango', libpango_dep)
```

# [[GTK4]]
- [bitWalk's: GTK4 を触ってみた (2) ～ Meson でビルド ～](https://bitwalk.blogspot.com/2020/12/gtk4-2-meson.html)

# Windows

- `PYTHONUTF8=1`  + UTF-8 locale は動く
- `PYTHONUTF8=1`  + not UTF-8 locale は動かない

```
The Meson build system
Version: 0.64.0
Source dir: C:\Users\oustt\Desktop\neovim-0.8.1
Build dir: C:\Users\oustt\Desktop\neovim-0.8.1\build
Build type: native build
Project name: neovim
Project version: undefined
Activating VS 17.4.0
C++ compiler for the host machine: cl (msvc 19.34.31933 "Microsoft(R) C/C++ Optimizing Compiler Version 19.34.31933 for x64")
C++ linker for the host machine: link link 14.34.31933.0
Host machine cpu family: x86_64
Host machine cpu: x86_64

meson.build:2:0: ERROR: No host machine compiler for 'src/nvim/main.c'
```

# gobject-instrospection
- [Mesonを使ってGObject Introspection対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)
