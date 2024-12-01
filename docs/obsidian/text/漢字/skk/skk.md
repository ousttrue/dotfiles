[[ime]] [[azik]]

    [@nathancorvussolis](https://nathancorvussolis.github.io/)

[リンク集 - SKK辞書Wiki](http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=%A5%EA%A5%F3%A5%AF%BD%B8)

GUI => TUI(PTY) => CUI

- `sticky shift`
- `sands`

# モードとキーマップ

## keymap の遷移

[fixedpoint.jp - SKK の submode 遷移 (2010-02-19)](https://fixedpoint.jp/2010/02/19/skk-graph.html)

# articles

- @2020 [かな漢字変換プログラム SKK の紹介 | Emacs JP](https://emacs-jp.github.io/tips/skk-intro)
- @2023 [SKK実装入門 (1) ローマ字 -> ひらがな変換](https://zenn.dev/uga_rosa/articles/ec5281d5a95a57)

# ローマ字

- [SKKで正字正かな](http://kstn.fc2web.com/skk_seikana.html)
- [変換/無変換キーでSKKのモードを変更する設定 · GitHub](https://gist.github.com/zonkyy/6404756)
- [かな入力時のローマ字変換にルール追加. - とりあえず暇だったし何となくはじめたブログ](https://khiker.hatenablog.jp/entry/20070120/emacs_skk)
- [corvusskk/installer/config-sample/kanatable.txt at 2.5.0 · nathancorvussolis/corvusskk · GitHub](https://github.com/nathancorvussolis/corvusskk/blob/2.5.0/installer/config-sample/kanatable.txt)

# 辞書

- @2023 [日本語IMEの変換ミスを解決するSKKが便利な話](https://zenn.dev/toriwasa/articles/946af5939093dc)
- [SKK辞書をパワーアップしてみた: 濃密金石文](http://nmksb.seesaa.net/article/476827902.html)

## format

- [SKK用語集 - SKK辞書Wiki](http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=SKK%CD%D1%B8%EC%BD%B8)
- @2016 [SKK-JISYO.lisp - みずぴー日記](https://mzp.hatenablog.com/entry/2016/04/19/214222)

```
# 見出し /変換候補;annotation/
なごや /名古屋;愛知/那古屋/
```

- @2018 [SKKを仮に実装する場合の難しそうなところ - 旅とプログラミングを少々](https://naokiri.hatenablog.com/entry/2018/05/04/102105)

# keybind

- [AquaSKK プロジェクト::キー割り当て](https://aquaskk.osdn.jp/keymap.html)

# frontend

## Windows

### skkfep

- [SKK日本語入力FEP 今だ！インストールだ！](http://coexe.web.fc2.com/skkinstall.html)

### Corvusskk

[Corvusskk](https://github.com/nathancorvussolis/corvusskk)

- @2023 [【レビュー】Windowsストアアプリ上での動作に対応した「SKK」風日本語入力システム「CorvusSKK」 - 窓の杜](https://forest.watch.impress.co.jp/docs/review/567771.html)

## TUI

- [GitHub - hymkor/gm: Golang Minimal text editor (凸)/](https://github.com/hymkor/gm)

### uim-fep

- http://quasiquote.org/log2/uim/Programming/Scheme/2010/12/23/skkserv

### sentimental-skk

[GitHub - saitoha/sentimental-skk: 三 三 ( ´\_ゝ`）＜ Japanese Input Method SKK (Simple Kana to Kanji conversion) on your terminal](https://github.com/saitoha/sentimental-skk)

## vim

[[vim_skk]]

## emacs

### ddskk

- [openlab.ring.gr.jp/skk/skk-manual/skk-15.1.pdf](http://openlab.ring.gr.jp/skk/skk-manual/skk-15.1.pdf)

# lib

- [GitHub - naokiri/cskk: SKK (Simple Kana Kanji henkan) library](https://github.com/naokiri/cskk)

# server

`辞書サーバー`
[SKK Openlab - サーバ](http://openlab.ring.gr.jp/skk/skkserv-ja.html)

## crvskkserv

[crvskkserv](https://github.com/nathancorvussolis/crvskkserv)

- @2022 [Windows10にSKKの環境を作る – RagtimeBlues](https://ragtimeblues.net/?p=226)
- @2022 [SKKメモ](https://zenn.dev/nazo6/scraps/40ac298709db14)

## yaskkserv2

https://github.com/wachikun/yaskkserv
http://umiushi.org/~wac/yaskkserv/

- @2021 [Rust製のSKKサーバーyaskkserv2をインストールして今度こそ快適に使う](https://arimasou16.com/blog/2021/05/02/00389/)

## skkserv

https://lurdan.hatenablog.com/entry/20101215/1292426956
https://github.com/nathancorvussolis/pcrvskkserv

# dict

- [GitHub - ymrl/SKK-JISYO.emoji-ja: 日本語の読みから Emoji に変換するための SKK 辞書 😂](https://github.com/ymrl/SKK-JISYO.emoji-ja)
- [GitHub - skk-dev/skktools: SKK dictionary maintenance tools](https://github.com/skk-dev/skktools)

# tools

- [GitHub - skk-dev/skktools: SKK dictionary maintenance tools](https://github.com/skk-dev/skktools)
  - [skktools/skkdic-sort.c at master · skk-dev/skktools · GitHub](https://github.com/skk-dev/skktools/blob/master/skkdic-sort.c)
