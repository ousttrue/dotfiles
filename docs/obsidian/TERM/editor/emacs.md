[[emacs_key]]
[[emacs_package]]

- [Index of /pub/GNU/emacs](http://ftp.jaist.ac.jp/pub/GNU/emacs/)

```
$ emacs -nw
```

- @2022 [Emacsのカレンダー | Advent Calendar 2022 - Qiita](https://qiita.com/advent-calendar/2022/emacs)
- @2022 [【簡単】Emacs基本的な設定ファイルの書き方【init.el】](https://suwaru.tokyo/%E3%80%90%E7%B0%A1%E5%8D%98%E3%80%91emacs%E5%9F%BA%E6%9C%AC%E7%9A%84%E3%81%AA%E8%A8%AD%E5%AE%9A%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E6%9B%B8%E3%81%8D%E6%96%B9%E3%80%90init-el%E3%80%91/)
- @2018 [自分の .emacs.d について書くよ - Qiita](https://qiita.com/takeokunn/items/7357c11a50ded45fdb3e)
- [前期実験i1i2i3 : Emacsのカスタマイズ](https://i1i2i3.eidos.ic.i.u-tokyo.ac.jp/html/tips/emacs.html)
- @2021 [My Emacs Config - ぐるっとぐりっど](https://www.grugrut.net/posts/my-emacs-init-el/)
- @2019 [use-packageについてまとめる | magcho's blog](https://blog.magcho.com/2019/12/use-package/)
- @2014 [use-package.el : Emacsの世界的権威が行っている最先端ラクラクinit.el整理術](http://emacs.rubikitch.com/use-package-2/)
- @2014 [use-packageで可読性の高いinit.elを書く - Qiita](https://qiita.com/kai2nenobu/items/5dfae3767514584f5220)
- @2022 [Emacs 29の eglotを使った Rust環境の設定 - Shohei Yoshida's Diary](https://syohex.hatenablog.com/entry/2022/11/08/000610)
- @2021 [Emacs での LSP と tree-sitter と lint](https://zenn.dev/eggc/articles/8541167f2dc4af)
- @2019 [Emacs で LSP を活用してみる - Qiita](https://qiita.com/blue0513/items/acc962738c7f4da26656)

# Version
## 29
- @2023 [Emacs 29 でTree-sitterを利用してシンタックスハイライトする](https://zenn.dev/hyakt/articles/42a1d237cdfa2a)
- builtin [[treesitter]]
- bultin `eglot`

## 27
- `early-init.el`

# .emacs.d
- [[備忘録] Emacs 初期化処理 整理](https://zenn.dev/0kate/articles/3d93b4a0263f53)
## init.el

# package
## use-package
- [GitHub - jwiegley/use-package: A use-package declaration for simplifying your .emacs](https://github.com/jwiegley/use-package)

# eglot

# syntax highlight

# build
- [Emacsをソースからビルドしてインストールする — my-emacs 0.1 ドキュメント](https://myemacs.readthedocs.io/ja/latest/build.html)
## msys2
素ではビルドできぬ
```sh
checking build system type... x86_64-pc-msys
checking host system type... x86_64-pc-msys
configure: error: Emacs does not support 'x86_64-pc-msys' systems.
```

configure.ac patch

[Failure building Emacs master as MSYS2 · Issue #2918 · msys2/MSYS2-packages · GitHub](https://github.com/msys2/MSYS2-packages/issues/2918)
```error
rebase: failed to open rebase database "/etc/rebase.db.x86_64"
```

# format
- [[Home] Reformat Buffer](https://www.emacswiki.org/emacs/ReformatBuffer)

# articles

- @2022 [Emacs をとにかくそれなりに使えるようにする – mhatta's mumbo jumbo](https://www.mhatta.org/wp/2022/12/25/how-to-use-emacs-without-tears-and-joint-pain/)
- @2017 [【Emacs 25-29】macOS, Windows, Ubuntuで共通なエディター環境を構築（まとめ） | The modern stone age.](https://www.yokoweb.net/2017/04/01/emacs-macos-msys2-ubuntu/)