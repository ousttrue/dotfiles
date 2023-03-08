[[font]]
[[NerdFont]]

> Bitmap Distribution Format

- [GitHub - Tecate/bitmap-fonts: Monospaced bitmap fonts for X11, good for terminal use.](https://github.com/Tecate/bitmap-fonts)
# [[yaft]]
[yaftを使う - すずしめにっき](https://suzusime-log.hatenablog.jp/entry/2018/11/16/024551)

`fonts/milkjf`
`tools/mkfont_bdf`

	> usage: tools/mkfont_bdf ALIAS_FILE BDF1 BDF2 BDF3 ... > glyph.h

同じコードポイントは先に出現したものが優先される。

```
glyph.h: mkfont_bdf
    # If you want to use your favorite fonts, please change following line
    # usage: mkfont_bdf ALIAS BDF1 BDF2 BDF3... > glyph.h
    # ALIAS: glyph substitution rule file (see table/alias for more detail)
    # BDF1 BDF2 BDF3...: monospace bdf files (must be the same size)
    # If there is more than one glyph of the same codepoint, the glyph included in the first bdf file is choosed
    ./mkfont_bdf table/alias fonts/milkjf/milkjf_k16.bdf fonts/milkjf/milkjf_8x16r.bdf fonts/milkjf/milkjf_8x16.bdf fonts/terminus/ter-u16n.bdf > glyph.h
```

# Cozette
6x13px
[GitHub - slavfox/Cozette: A bitmap programming font optimized for coziness 💜](https://github.com/slavfox/Cozette)

# Ufo
8x16px
- [Ufo by akahuku](https://akahuku.github.io/ufo/)

# Other
- [自家製ドットフォントシリーズ | 自家製フォント工房](http://jikasei.me/font/jf-dotfont/)
- [ばぐまるゴシック - ばぐばぐソフト](https://debugx.net/BugSoft.aspx?Soft=BugMaruGothic)
