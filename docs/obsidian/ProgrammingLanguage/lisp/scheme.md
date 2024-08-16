- http://www7b.biglobe.ne.jp/~saia/scheme.html
- [Scheme 入門 1. Scheme 処理系のインストール](https://www.shido.info/lisp/scheme1.html)
- [ノート:Scheme - Wikipedia](https://ja.wikipedia.org/wiki/%E3%83%8E%E3%83%BC%E3%83%88%3AScheme)

- @2018 [chibi-scheme 0.8 / Sagittarius + MinGW / Racketは7でChezに移行する？ - .mjtの日記復帰計画](https://mjt.hatenadiary.com/entry/20180128/p1)
- @2014 [時の羅針盤＠blog: Scheme処理系の選び方](https://compassoftime.blogspot.com/2014/01/scheme.html)
- @2012 [VimでのSchemeプログラミング - 再帰の反復blog](https://lemniscus.hatenablog.com/entry/20120409/1333942456)

# Version

## R7RS

[[R7RS]]

### R7RS-small

### R7RS Pico

## R6RS

> R5RS に比べて急激に大きくなった

## R5RS

- [https://www.unixuser.org/~euske/doc/r5rs-ja/r5rs-ja.pdf](https://www.unixuser.org/~euske/doc/r5rs-ja/r5rs-ja.pdf)

## SRFI

# literal

```scm
#t #f
1
"str"
```

# 処理系

## ChezScheme

`R6RS`

## interpreter

### chibi-scheme

`R7RS`

- https://github.com/ashinn/chibi-scheme/

### guile

[guile メモ](http://7ujm.net/etc/guile.html)

- [GNU GuileのScheme処理系APIをC言語から利用する記述のサンプル - Qiita](https://qiita.com/ytaki0801/items/83f8bc510342b7945519)

### gauche

@2022 `0.9.12`

- [GitHub - shirok/Gauche: Scheme Scripting Engine](https://github.com/shirok/Gauche)
- [Gauche - A Scheme Implementation](https://practical-scheme.net/gauche/index-j.html)

### mosh

`mona os`

- [About - Mosh](https://mosh.monaos.org/files/doc/text/About-txt.html)
- [GitHub - higepon/mosh: Mosh is a free and fast interpreter for Scheme as specified in the R6RS.](https://github.com/higepon/mosh)
- @2022 [mosh(-scheme)の開発にキャッチアップする](https://zenn.dev/okuoku/scraps/d7484b85fecd18)
- @2022 [Mosh の Apple Silicon 対応 - 2022夏休み - higepon blog](https://higepon.hatenablog.com/entry/2022/08/04/171319)

### sigscheme

[[uim]] [[sigscheme]]

### s7

`R5RS` `R7RS`

- @2021 [C++にScheme処理系を楽して組み込みたい - Qiita](https://qiita.com/ossan-buhibuhi/items/98520f3adb1c70cb0475)
- [s7](https://ccrma.stanford.edu/software/snd/snd/s7.html)

## compiler

### chicken

`RSR5`

## transpiler

### gambit

http://gambitscheme.org/
[Gambit Scheme： その2 ポータビリティー - karasuyamatenguの日記](https://karasuyamatengu.hatenadiary.org/entry/20101104/1288850582)

## other

- [GitHub - ignorabimus/tinyscheme: Experimental fork of TinyScheme and extensions TSX, RE.](https://github.com/ignorabimus/tinyscheme)
- [GitHub - microsoft/schemy: A lightweight embeddable Scheme-like interpreter for configuration](https://github.com/microsoft/schemy)

# LSP

`chicken`

- [lsp-server - The CHICKEN Scheme wiki](https://wiki.call-cc.org/eggref/5/lsp-server)
- [rgherdt/scheme-lsp-server: An LSP server for Scheme. - scheme-lsp-server - Codeberg.org](https://codeberg.org/rgherdt/scheme-lsp-server)

## chez

- [GitHub - ufo5260987423/scheme-langserver: Scheme language server](https://github.com/ufo5260987423/scheme-langserver)

# formatter

- [scheme-style](http://community.schemewiki.org/cgi-bin/scheme.cgi?scheme-style)
