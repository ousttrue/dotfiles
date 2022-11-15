#red
[[pygobject]]

- [Overview — GObject Introspection](https://gi.readthedocs.io/en/latest/)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)
- [Mesonを使ってGObject Introspection対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)

- [Python and GObject Introspection](https://www.slideshare.net/yurenju/python-and-gobject-introspection)

# build
- [MSVC.README.rst · main · GNOME / gobject-introspection · GitLab](https://gitlab.gnome.org/GNOME/gobject-introspection/-/blob/main/MSVC.README.rst)

## 1st
- gobject-introspection


```
# MINGW64
$ PKG_CONFIG_PATH=C:/gnome/lib/pkgconfig meson setup build --prefix=C:/gnome -Dbuild_introspection_data=false -Dpython=C:/Python310/python.exe
```

```
> meson setup build --prefix C:/gnome -Dbuild_introspection_data=false

glib 2.75.1
  Build environment
    host cpu           : x86_64
    host endian        : little
    host system        : windows
    C Compiler         : msvc
    C++ Compiler       : msvc
    shared build       : True
    static build       : False

  Directories
    prefix             : C:/gnome
    bindir             : C:/gnome/bin
    libexecdir         : C:/gnome/libexec
    pkgdatadir         : C:/gnome/share/glib-2.0
    datadir            : C:/gnome/share
    includedir         : C:/gnome/include/glib-2.0
    giomodulesdir      : C:/gnome/lib/gio/modules
    localstatedir      : C:/gnome/var

  Options
    xattr              : False
    man                : False
    dtrace             : False
    systemtap          : False
    sysprof            : False
    gtk_doc            : False
    bsymbolic_functions: True
    force_posix_threads: False
    tests              : True
    installed_tests    : False
    nls                : auto
    oss_fuzz           : disabled
    glib_debug         : auto
    glib_assert        : True
    glib_checks        : True
    libelf             : auto
    multiarch          : False

gobject-introspection 1.74.1

  Subprojects
    glib                    : YES 1 warnings
    gvdb                    : YES
    libffi                  : YES
    pcre2                   : YES
    proxy-libintl           : YES 1 warnings
    zlib                    : YES

  User defined options
    prefix                  : C:/gnome
    build_introspection_data: false
```

```
> pkg-config --list-all
gio-windows-2.0                     GIO Windows specific APIs - Windows specific headers for glib I/O library
gthread-2.0                         GThread - Thread support for GLib
gobject-introspection-1.0           gobject-introspection - GObject Introspection
gmodule-2.0                         GModule - Dynamic module loader for GLib
gobject-introspection-no-export-1.0 gobject-introspection - GObject Introspection
gmodule-export-2.0                  GModule - Dynamic module loader for GLib
libffi                              ffi - Library supporting Foreign Function Interfaces
zlib                                zlib - zlib compression library
gobject-2.0                         GObject - GLib Type, Object, Parameter and Signal Library
gio-2.0                             GIO - glib I/O library
gmodule-no-export-2.0               GModule - Dynamic module loader for GLib
libpcre2-8                          libpcre2-8 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 8 bit character support
libpcre2-16                         libpcre2-16 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 16 bit character support
libpcre2-32                         libpcre2-32 - PCRE2 - Perl compatible regular expressions C library (2nd API) with 32 bit character support
glib-2.0                            GLib - C Utility Library
```

## 2nd
```
> meson setup build --prefix C:/gnome
```

# GIR
`XDG_DATA_DIRS/gir-1.0`

## # g-ir-scanner
- [g-ir-scanner(1) — gobject-introspection — Debian experimental — Debian Manpages](https://manpages.debian.org/experimental/gobject-introspection/g-ir-scanner.1.en.html#ENVIRONMENT_VARIABLES)
`GI_EXTRA_BASE_DLL_DIRS`
[[python]]
- [GIR's can't be built in Windows with Python >= 3.8 using subprojects. (#416) · Issues · GNOME / gobject-introspection · GitLab](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/416)
- [pango 1.48 does not build with harfbuzz, trying to find 'HarfBuzz-0.0.gir' (#522) · Issues · GNOME / pango · GitLab](https://gitlab.gnome.org/GNOME/pango/-/issues/522)

# repository: typelib
`PREFIX/lib/girepository-1.0`

## copy gir
- [GitHub - gtk-rs/gir-files](https://github.com/gtk-rs/gir-files)

# libgirepository
- [libgirepository — GObject Introspection](https://gi.readthedocs.io/en/latest/writingbindings/libgirepository.html)

## g_function_info_invoke
- [GIFunctionInfo: libgirepository API Reference](https://gnome.pages.gitlab.gnome.org/gobject-introspection/girepository/gi-GIFunctionInfo.html#g-function-info-invoke)

# python-3.10 のときに起きたエラーたち・・・

python-3.7

## UnicodeDecodeError: 'utf-8' codec can't decode byte 0x8e in position 115: invalid start byte

煩わしいのでシステムロケールを `utf-8`した。

## 大量のエラー glib-types.h

```
g-ir-cpp-exo0vmyg.c
C:\gnome\include\glib-2.0\gobject\glib-types.h:338: syntax error, unexpected identifier in 'GOBJECT_AVAILABLE_IN_ALL' at 'GOBJECT_AVAILABLE_IN_ALL'
```

`g-ir-cpp-` で検索。
`giscanner\sourcescanner.py` でコード生成していることがわかる。

`glib-types.h` には

```c
#error "Only <glib-object.h> can be included directly."
```

と書いてある。
`gobject/glib-types.h` を `glib-object.h` で置き換えてみる。
`gir/meson.build` を書き換えてみる。

```meson
glib_files += join_paths(glib_incdir, 'gobject', 'glib-types.h')
👇
glib_files += join_paths(glib_incdir, 'glib-object.h')
```

### `linking of temporary binary failed`

```
LINK : fatal error LNK1181: cannot open input file 'gio-2.0.lib'

--- stderr ---
Microsoft (R) C/C++ Optimizing Compiler Version 19.29.30146 for x64
Copyright (C) Microsoft Corporation.  All rights reserved.

g-ir-cpp-f84ipeuo.c
linking of temporary binary failed: Command '['link.exe', '-out:C:\\ghq\\github.com\\GNOME\\gobject-introspection\\build\\tmp-introspectm8c95rt9\\GLib-2.0.exe', 'C:\\ghq\\github.com\\GNOME\\gobject-introspection\\build\\tmp-introspectm8c95rt9\\GLib-2.0.obj', '/libpath:C:/gnome/lib.lib', 'gio-2.0.lib', 'gobject-2.0.lib', 'gmodule-2.0.lib', 'glib-2.0.lib', 'intl.lib', 'glib-2.0.lib', 'gobject-2.0.lib']' returned non-zero exit status 1181.    
```

`/libpath:C:/gnome/lib.lib` が `/libpath:C:/gnome/lib` であるべき。

`linking of temporary binary failed` で検索すると
`giscanner\dumper.py` で例外が起きていることが分かります。

:::note info
giscanner/dumper.py は ninja 経由で実行されているので break できませんでした。
:::

print debug で場所を発見。

```python
            subprocess.check_call(args)
```

### ERROR: can't resolve libraries to shared libraries: glib-2.0, gobject-2.0

`can't resolve libraries to shared libraries` で検索。

`giscanner\ccompiler.py` に発見。

例外をもみ消した w

```python
        if len(not_resolved) > 0:
            raise SystemExit(
                "ERROR: can't resolve libraries to shared libraries: " +
                ", ".join(not_resolved))
```

```python
        # When we are using Visual C++ or clang-cl...
        if self.check_is_msvc():
            # The search path of the .lib's on Visual C++
            # is dependent on the LIB environmental variable,
            # so just query for that
            libpath = os.environ.get('LIB')
            libsearch = libpath.split(';')
```

環境変数

`LIB=C:/gnome/lib` 

で解決。

### FAILED: tests/GIMarshallingTests-1.0.gir

test ぽいのでスキップしよう。

```meson:meson.build
#if not meson.is_cross_build()
#  subdir('tests')
#endif
```

## cairo のビルド

## pygobject のビルド

# python 実験

```python
import cairo
print(cairo)
```

## ModuleNotFoundError: No module named 'cairo'

`module が無いエラー`

```
PYTHONPATH=C:\gnome\lib\site-packages
```

## ImportError: DLL load failed while importing _cairo: 指定されたモジュールが見つかりません。
****
`pyd のロードエラー`

python-3.8 で pyd の import 仕様が変更になっています。

```python
import os
os.add_dll_directory('c:/gnome/bin')
```

が必要です。

```python
import gi
gi.require_version("GLib", "2.0")
from gi.repository import GLib
print(GLib)
****```
