[FontForge Open Source Font Editor](https://fontforge.org/en-US/)

- https://github.com/fontforge/fontforge

- @2022 [fontforgeによる等幅合成フォント作成時の注意点 · GitHub](https://gist.github.com/retorillo/0c80dea974816731a493afbc3a70fef2)
- @2020 `fontforge` `python` [SF Mono を使って最高のプログラミング用フォントを作った話 #Python - Qiita](https://qiita.com/delphinus/items/f472eb04ff91daf44274)

# Document

[Design With FontForge](http://designwithfontforge.com/en-US/index.html)

# composite

- `fontforge` [フォントの合成 (1)](https://aznote.jakou.com/fforge/02_merge.html)
- `fontforge` [フォントの合成 - ふなWiki](https://blue-red.ddo.jp/~ao/wiki/wiki.cgi?page=%A5%D5%A5%A9%A5%F3%A5%C8%A4%CE%B9%E7%C0%AE)

# python

- @2023 `fontforge` [FontForgeとPythonでGlyph (Contour) の編集(追加・削除)方法](https://ryota2357.com/blog/2023/fontforge-add-erase-glyph-with-python/)
- [FontForge 講座](https://aznote.jakou.com/fforge/index.html)
- @2015 [FontForge の Python bindings を使えるようにする - にせねこメモ](https://nixeneko.hatenablog.com/entry/2015/05/21/002602)

```py
import fontforge

font = fontforge.font()
font.mergeFonts('SFMono-Regular.otf')
font.mergeFonts('migu-1m-regular.ttf')
font.generate('merged-font.ttf')
```

`1000-em`
`2028-em`
