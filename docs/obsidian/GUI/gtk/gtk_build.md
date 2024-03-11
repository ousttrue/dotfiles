# env

```sh
$env:MSSdk="1"
$env:DISTUTILS_USE_SDK="1"
```

# glib

```sh
meson setup builddir --prefix "$HOME/local" -Dintrospection=disabled
```

# pkg-config

```Makefile.vc
GLIB_PREFIX = $(USERPROFILE)\local
```

# glib-introspection

