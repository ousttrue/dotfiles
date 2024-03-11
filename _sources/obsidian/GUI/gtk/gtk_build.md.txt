# env

```sh
$env:MSSdk="1"
$env:DISTUTILS_USE_SDK="1"

$ pip install packaging setuptools
```

# glib

```sh
$ meson setup builddir --prefix "$HOME/local" -Dbuildtype=release -Dintrospection=disabled

 Subprojects
    gvdb               : YES
    libffi             : YES 1 warnings
    pcre2              : YES 1 warnings
    proxy-libintl      : YES 2 warnings
    zlib               : YES

  User defined options
    buildtype          : release
    prefix             : $HOME/local
    introspection      : disabled
```

# pkg-config

```Makefile.vc
GLIB_PREFIX = $(USERPROFILE)\local
```

# glib-introspection

```sh
$ meson setup builddir --prefix "$HOME/local" -Dbuildtype=release

gobject-introspection 1.80.1

  User defined options
    buildtype: release
    prefix   : $HOME/local
```

```sh
$HOME\local\include\glib-2.0\glib\gstring.h:193: syntax error
```

`fix libpcre2-8`

```sh
$env:LIB += "$HOME\local\lib"
```

# glib

`-Dintrospection=enabled`

# vulkan sdk

fix meson

# gtk

```sh
$ meson setup builddir --prefix "$HOME/local" -Dbuildtype=release -Dmedia-gstreamer=disabled

  Subprojects
    cairo           : YES 3 warnings
    expat           : YES (from cairo => fontconfig)
    fontconfig      : YES 5 warnings (from cairo)
    freetype2       : YES 6 warnings (from cairo => fontconfig)
    fribidi         : YES (from pango)
    gdk-pixbuf      : YES 2 warnings
    gi-docgen       : NO python3 is missing modules: jinja2, markdown, markupsafe, pygments, typogrify
    gperf           : YES (from cairo => fontconfig)
    graphene        : YES 1 warnings
    harfbuzz        : YES 20 warnings (from pango)
    libepoxy        : YES
    libjpeg-turbo   : YES (from gdk-pixbuf)
    libpng          : YES (from cairo)
    libsass         : YES (from sassc)
    libtiff         : YES
    pango           : YES
    pixman          : YES (from cairo)
    proxy-libintl   : NO Neither a subproject directory nor a proxy-libintl.wrap file was found.
    sassc           : YES

  User defined options
    buildtype       : release
    prefix          : $HOME/local
    media-gstreamer : disabled
```




