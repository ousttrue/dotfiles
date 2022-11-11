[[pygobject]]

- [Overview — GObject Introspection](https://gi.readthedocs.io/en/latest/)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)
- [Mesonを使ってGObject Introspection対応のビルドシステムを構築する方法 - 2022-08-17 - ククログ](https://www.clear-code.com/blog/2022/8/17/meson-and-gobject-introspection.html)
- [workshop-materials/introduction.md at master · RubyData/workshop-materials · GitHub](https://github.com/RubyData/workshop-materials/blob/master/gobject-introspection/introduction.md)

# build
## 1st
- glib-introspection
```
> meson setup build --prefix D:/gnome -Dbuild_introspection_data=false
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

# GIR
`PREFIX/share/gir-1.0`

## # g-ir-scanner
`GI_EXTRA_BASE_DLL_DIRS`
[[python]]
- [GIR's can't be built in Windows with Python >= 3.8 using subprojects. (#416) · Issues · GNOME / gobject-introspection · GitLab](https://gitlab.gnome.org/GNOME/gobject-introspection/-/issues/416)
- [pango 1.48 does not build with harfbuzz, trying to find 'HarfBuzz-0.0.gir' (#522) · Issues · GNOME / pango · GitLab](https://gitlab.gnome.org/GNOME/pango/-/issues/522)

# repository: typelib
`PREFIX/lib/girepository-1.0`

## copy gir
- [GitHub - gtk-rs/gir-files](https://github.com/gtk-rs/gir-files)
