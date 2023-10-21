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
