- [GitHub - GNOME/gtk: Read-only mirror of https://gitlab.gnome.org/GNOME/gtk](https://github.com/GNOME/gtk)

- [Gtk – 4.0](https://docs.gtk.org/gtk4/index.html)

  - [Gtk – 4.0: Overview of the drawing model](https://docs.gtk.org/gtk4/drawing-model.html)

# Version

偶数が `stable`

## 4.18

## 4.12

- @2023 [GTK 4.12 Released With Many Vulkan Backend Improvements](https://www.phoronix.com/news/GTK-4.12-Released)

## 4.10

- `わりとたくさんの変更` @2023 [おもこん](https://toshiocp.com/)

## 4.8 @2022

- [NEWS · gtk-4-8 · GNOME / gtk · GitLab](https://gitlab.gnome.org/GNOME/gtk/-/blob/gtk-4-8/NEWS)

## 4.6 @2021

- Ubuntu-22.04

## 4.4

- @2021 [GTK 4.4 – GTK Development Blog](https://blog.gtk.org/2021/08/23/gtk-4-4/)

## 4.2

- [GTK 4 NGL Renderer – Happenings in GNOME](https://blogs.gnome.org/chergert/2021/02/24/gtk-4-ngl-renderer/)

## 4.0

- @2020 [bitWalk's: GTK4 を触ってみた (2) ～ Meson でビルド ～](https://bitwalk.blogspot.com/2020/12/gtk4-2-meson.html)
- @2020 [「GTK 4」が公開、メディア再生サポートなどが加わる | OSDN Magazine](https://mag.osdn.jp/20/12/18/132200)

# nodeview

- https://github.com/aluntzer/gtknodes

# tutorial

- @2022 `nim` [GTK4 for Graphical User Interfaces](https://ssalewski.de/gtkprogramming.html)
- [ ] [Site Unreachable](https://toshiocp.com/entry/2022/07/07/095955)
- [ ] [GTK 4 tutorial](https://toshiocp.github.io/Gtk4-tutorial/)

# vala

[Projects/Vala/GTK4Sample - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/GTK4Sample?highlight=%28%5CbVala%2FExamples%5Cb%29)

```cpp
using Gtk;

int main(string[] argv) {
	// Create a new application
	var app = new Gtk.Application("com.example.GtkApplication",
	                              GLib.ApplicationFlags.FLAGS_NONE);
	app.activate.connect(() => {
		var window = new Gtk.ApplicationWindow(app);
		var button = new Gtk.Button.with_label("Hello, World!");

		button.clicked.connect(() => { window.close(); });

		window.set_child(button);
		window.present();
	});
	return app.run(argv);
}
```
