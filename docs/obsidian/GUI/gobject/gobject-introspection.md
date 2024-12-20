[[pygobject]]

**循環参照** `glib <- gobject-introspection <- glib(gir)`

- https://www.bassi.io/articles/2023/10/25/introspections-edge/

- [Overview — GObject Introspection](https://gi.readthedocs.io/en/latest/)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)
- [Meson を使って GObject Introspection 対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)

- [Python and GObject Introspection](https://www.slideshare.net/yurenju/python-and-gobject-introspection)

- [GObject Introspection入門](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)

# doc

- [GitHub - pygobject/pgi-docgen: API Documentation Generator for PyGObject](https://github.com/pygobject/pgi-docgen)

# lua

- [How to use Gio.Socket? · Issue #235 · lgi-devs/lgi · GitHub](https://github.com/lgi-devs/lgi/issues/235)
- [GitHub - lgi-devs/lgi: Dynamic Lua binding to GObject libraries using GObject-Introspection](https://github.com/lgi-devs/lgi)

# build

- [MSVC.README.rst · main · GNOME / gobject-introspection · GitLab](https://gitlab.gnome.org/GNOME/gobject-introspection/-/blob/main/MSVC.README.rst)

# GIR

`XDG_DATA_DIRS=prefix/share` `+`/gir-1.0

[[Ubuntu]] では `typelib` が配布されていて、元となる `gir` ファイルは `apt` に含まれていなかった。

- [GitHub - gtk-rs/gir-files](https://github.com/gtk-rs/gir-files)

## g-ir-scanner

- [g-ir-scanner(1) — gobject-introspection — Debian experimental — Debian Manpages](https://manpages.debian.org/experimental/gobject-introspection/g-ir-scanner.1.en.html#ENVIRONMENT_VARIABLES)
  `GI_EXTRA_BASE_DLL_DIRS`
  [[python]]
- [GIR's can't be built in Windows with Python >= 3.8 using subprojects. (#416) · Issues · GNOME / gobject-introspection · GitLab](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/416)
- [pango 1.48 does not build with harfbuzz, trying to find 'HarfBuzz-0.0.gir' (#522) · Issues · GNOME / pango · GitLab](https://gitlab.gnome.org/GNOME/pango/-/issues/522)

# repository: typelib

`PREFIX/lib/girepository-1.0`

# libgirepository

- [libgirepository — GObject Introspection](https://gi.readthedocs.io/en/latest/writingbindings/libgirepository.html)

## g_function_info_invoke

- [GIFunctionInfo: libgirepository API Reference](https://gnome.pages.gitlab.gnome.org/gobject-introspection/girepository/gi-GIFunctionInfo.html#g-function-info-invoke)
