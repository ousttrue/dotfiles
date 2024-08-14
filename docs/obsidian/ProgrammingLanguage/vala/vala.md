- [Vala Programming Language](https://vala.dev/)
- https://vala.gitbook.io/vala/v/english/

[Introduction · The vala Tutorial](https://naaando.gitbooks.io/the-vala-tutorial/content/en/)

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
```# Version

## 0.56

- @2022 [Vala 0 56](https://vala.dev/blog/vala-0-l56/)

# articles

- @2022 [【Vala 言語】優れた点、Linux における立ち位置、物足りなさとその対策（core ライブラリ開発）](https://debimate.jp/2022/01/05/%E3%80%90vala%E8%A8%80%E8%AA%9E%E3%80%91%E5%84%AA%E3%82%8C%E3%81%9F%E7%82%B9%E3%80%81linux%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E7%AB%8B%E3%81%A1%E4%BD%8D%E7%BD%AE%E3%80%81%E7%89%A9%E8%B6%B3%E3%82%8A/)
- @2022 [GStreamer/GTK/Vala でサウンドレコーダーアプリを作ってみた - Qiita](https://qiita.com/ryonakano/items/0023bcead9b75ad99aee)

- @2021 [Vala （C Generator) - Paepoi](https://palepoli.skr.jp/tips/glib/vala.php)
- @2020 [bitWalk's: Vala でオブジェクト指向プログラミング](https://bitwalk.blogspot.com/2020/06/vala_22.html)
- @2020 [bitWalk's: Vala を試してみた](https://bitwalk.blogspot.com/2020/06/vala.html)
- @2015 [高機能なマイナープログラミング言語Valaについて - kakurasan](https://kakurasan.blogspot.com/2015/06/vala-minor-programming-language.html)

# dev

## vim

[Vala](https://github.com/vala-lang/vala.vim)[GitHub - vala-lang/vala.vim: Vala syntax highlighting, indentation, snippets and more for Vim](https://github.com/vala-lang/vala.vim)

## lsp

[GitHub - vala-lang/vala-language-server: Code Intelligence for Vala & Genie](https://github.com/vala-lang/vala-language-server)

- @2020 [Vala 言語の開発環境構築 (Vim on Ubuntu20.04 on WSL2) | yhoka's blog](https://www.yhoka.com/posts/vala-dev-env/)

`compile_commands.json` を project root から search する。
たぶん、project root の meson.build を経由して発見できる。

## formatter

clang-format は、 lambda の `=>` を分解してしまうのでダメ。


### vala-lint

- [Code formatter for Vala - Platform - GNOME Discourse](https://discourse.gnome.org/t/code-formatter-for-vala/14979)
- [Vala-LintをVimで扱う | inthisfucking.world](https://inthisfucking.world/ale-for-vala-lint/)

## meson

https://mesonbuild.com/Vala.html

- @2020 [Site Unreachable](https://bitwalk.blogspot.com/2020/06/vala-meson.html)
- @2020 [Vala Meson](https://bitwalk.blogspot.com/2020/08/vala-meson.html)

[Vala](https://mesonbuild.com/Vala.html)
[Projects/Vala/Tools/Meson - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/Tools/Meson)

```
vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')
```

# tutorial

[Examples](https://wiki.gnome.org/Projects/Vala/Examples)[Projects/Vala/Examples - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/Examples)

- [Documentation](https://wiki.gnome.org/Projects/Vala/Documentation)[Projects/Vala/Documentation - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/Documentation)
- [Projects/Vala/BasicSample - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/BasicSample)
- [Projects/Vala/Tutorial - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/Tutorial)
- [GStreamerSample](https://wiki.gnome.org/Projects/Vala/GStreamerSample)[Projects/Vala/GStreamerSample - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/GStreamerSample)
- [GitHub - Apress/introducing-vala-programming: Source Code for 'Introducing Vala Programming' by Michael Lauer](https://github.com/Apress/introducing-vala-programming/tree/master)
  [190948](https://onagat.hatenablog.com/entry/2015/02/27/190948)[Vala 言語と OpenGL - WebGPU プログラミング](https://onagat.hatenablog.com/entry/2015/02/27/190948)
- [Gee](https://github.com/frida/vala/tree/main/gee)[gee](https://github.com/frida/vala/tree/main/gee)

## entrypoint

```cpp
void main () {
    print ("hello, world\n");
}
```

C# とか Java ぽいが無意味。

```cpp
class Sample : Object {
  static void main(string[] args) {
    print ("hello, world\n");
  }
}
```

[[GObject]]

# Windows build

- @2023 [Windows woes | Google Summer of Code 2019 for Dino](https://hrxi.github.io/gsoc/blog/windows-woes)

- [GitHub - ZacharyJia/vala-win: build vala compiler for windows](https://github.com/ZacharyJia/vala-win)
- https://lists.gnome.org/archives/commits-list/2022-January/msg09801.html
- https://github.com/frida/vala

```sh
$ valac --version
Vala 0.58.0-frida
```

# vapi

vala は vapi を通して c library を使う。

- GObject は, gir から vapi を自動生成できる(たぶん)
- 他の C library は、手書き(たぶん)

## OpenGL

- https://wiki.gnome.org/Projects/Vala/OpenGLSamples
- https://onagat.hatenablog.com/entry/2015/02/27/190948

## system

`/usr/share/vala-0.56/vapi`

```
$ sudo apt install valac-0.56-vapi
```

## Generate

- [Projects/Vala/Bindings - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/Bindings)

## extra

[Files · master · GNOME / vala-extra-vapis · GitLab](https://gitlab.gnome.org/GNOME/vala-extra-vapis/-/tree/master)

[OpenGL VAPI Missing - Platform / Language bindings - GNOME Discourse](https://discourse.gnome.org/t/opengl-vapi-missing/5079)

# OpenGL

[Projects/Vala/OpenGLSamples - GNOME Wiki!](https://wiki.gnome.org/Projects/Vala/OpenGLSamples)
https://onagat.hatenablog.com/entry/2016/05/04/010306

# nvim

https://github.com/sakhnik/neovim-vala
