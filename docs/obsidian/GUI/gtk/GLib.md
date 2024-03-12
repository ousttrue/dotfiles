- @2023 [halting problem : Introspection’s edge](https://www.bassi.io/articles/2023/10/25/introspections-edge/)

> glib, gmodule, gobject, gio...

[[gtk]]
# IOChannel

- @2017 [GIOChannel @ Gjs, PyGObject | Paepoi Blog](https://palepoli.skr.jp/wp/2017/01/22/giochannel-gjs-pygobject/)
- [python - Why do io_add_watch() callbacks receive the wrong IOChannel object? - Stack Overflow](https://stackoverflow.com/questions/54719569/why-do-io-add-watch-callbacks-receive-the-wrong-iochannel-object)



[[meson]]   [[gobject-introspection]]

- `meson` @2021 [GObjectについて - チラシの表の反対側](https://www.kofuk.org/blog/20210622-gobject/)

# vala
[[vala]]

[Index](https://valadoc.org/gobject-2.0/index.htm)[index.htm – gobject-2.0](https://valadoc.org/gobject-2.0/index.htm)

参照カウント方式。Destructor OK なので `RAII` できる。
```cpp
/* class derived from GObject */
class BasicSample : Object {
public
  BasicSample() { stdout.printf("new\n"); }
  ~BasicSample() { stdout.printf("delete\n"); }

  /* public instance method */
public
  void run() { stdout.printf("Hello World\n"); }
}

/* application entry point */
int main (string[] args) {
  var sample = new BasicSample();
  sample.run();
  return 0;
}
```
