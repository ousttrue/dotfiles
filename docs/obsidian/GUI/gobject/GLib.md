https://gitlab.gnome.org/GNOME/glib

- https://github.com/GNOME/glib/tree/main

- `meson` @2021 [GObjectについて - チラシの表の反対側](https://www.kofuk.org/blog/20210622-gobject/)

# API Version: 2.0

# Version

## 2.81.1 @202408

# glib-genmarshal

https://github.com/bratsche/glib/blob/master/gobject/glib-genmarshal.c

# build / dependencies

- https://docs.gtk.org/glib/building.html

## glib.h and glibconf.h

生成 header

```meson
glib_conf = configuration_data()
configure_file(output : 'config.h', configuration : glib_conf)

glibconfig_conf = configuration_data()
glibconfig_h = configure_file(input : 'glibconfig.h.in', output : 'glibconfig.h',
  install_dir : join_paths(get_option('libdir'), 'glib-2.0/include'),
  install_tag : 'devel',
  configuration : glibconfig_conf)
glib_sources += glibconfig_h
```

```zig
    var user_config = b.addConfigHeader(.{
        .style = .{ .cmake = .{ .path = "conf.h.in" } },
        .include_path = "foo/conf.h",
    }, .{});
```

- [bluepyのインストール時に、glib.h、glibconfig.hがないと言われてうまくいかなかったので対処 - 工作と競馬2](https://dekuo-03.hatenablog.jp/entry/2020/03/09/130807)

## iconv

https://www.gnu.org/software/libiconv/

win_iconv が glib に含まれている。

## python3

Python 3.5 or newer is required.

## libintl

http://www.gnu.org/software/gettext

- https://github.com/frida/proxy-libintl

## PCRE

http://www.pcre.org/

- https://github.com/PCRE2Project/pcre2

## gobject-introspection

- @2023 [halting problem : Introspection’s edge](https://www.bassi.io/articles/2023/10/25/introspections-edge/)

https://gitlab.gnome.org/GNOME/gobject-introspection/

# IOChannel

- @2017 [GIOChannel @ Gjs, PyGObject | Paepoi Blog](https://palepoli.skr.jp/wp/2017/01/22/giochannel-gjs-pygobject/)
- [python - Why do io_add_watch() callbacks receive the wrong IOChannel object? - Stack Overflow](https://stackoverflow.com/questions/54719569/why-do-io-add-watch-callbacks-receive-the-wrong-iochannel-object)
