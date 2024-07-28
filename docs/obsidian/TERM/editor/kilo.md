[[tui_app]]

- [GitHub - antirez/kilo: A text editor in less than 1000 LOC with syntax highlight and search.](https://github.com/antirez/kilo)
- [GitHub - csb6/editorial: A TUI text editor written in C++](https://github.com/csb6/editorial)

# memo

- keyboard input の rawmode 化と `SIGWINCH` 等のハンドリングに `termios.h` や `unistd.h` を使っている。そこを代替すれば `Windows` でも動作させることができる。
- [[curses]] は使っていない

# articles

- [Build Your Own Text Editor](https://viewsourcecode.org/snaptoken/kilo/)
- [GitHub - antirez/kilo: A text editor in less than 1000 LOC with syntax highlight and search.](https://github.com/antirez/kilo)

- @2020 [小規模なテキストエディタを実装しながらプログラミングとUnit testを学んでみよう](https://zenn.dev/freddiefujiwara/articles/652c59bf65894f2eb76d)
- @2019 [ターミナル用 UTF-8 テキストエディタを Rust でスクラッチからつくった - はやくプログラムになりたい](https://rhysd.hatenablog.com/entry/2019/08/29/091753)

- @2016 [【連載】C言語1000行以下のエディタ「Kilo」を理解する | TECH+（テックプラス）](https://news.mynavi.jp/techplus/series/kilo/)
  - [C言語1000行以下のエディタ「Kilo」を理解する(1) シンプルな内部構造 | TECH+（テックプラス）](https://news.mynavi.jp/techplus/article/kilo-1/)
  - [C言語1000行以下のエディタ「Kilo」を理解する(2) フローを追う | TECH+（テックプラス）](https://news.mynavi.jp/techplus/article/kilo-2/)
- @2016 [GitHub - algebroid/learn-kilo: japanese translation of kilo tutorial](https://github.com/algebroid/learn-kilo)

- @2016 [Kilo - 1000行以下のコードで実装された超コンパクトなテキストエディタ | ソフトアンテナ](https://softantenna.com/blog/kilo/)

# vi-key

- https://github.com/search?q=vim%20kilo&type=repositories

- https://github.com/taidanh/kilo
