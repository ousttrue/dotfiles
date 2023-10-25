DirectWrite emoji
#DirectWrite #emoji #GlyphRun

`Segoe UI Emoji font`

[* Glyph]
	https://github.com/Microsoft/Windows-universal-samples/tree/master/Samples/DWriteColorGlyph
	https://docs.microsoft.com/en-us/windows/desktop/DirectWrite/color-fonts

	https://docs.microsoft.com/en-us/windows/desktop/directwrite/color-fonts#using-color-fonts-with-directwrite-and-direct2d
		https://wontfix.blogspot.com/2014/03/rendering-color-emoji-using-glyph-with.html

`IDWriteFactory2::TranslateColorGlyphRun`
`IDWriteFactory4::TranslateColorGlyphRun`

モノクロの`DWRITE_GLYPH_RUN` を `TranslateColorGlyphRun` によってカラーのGlyphRunに変換する必要がある
`TranslateColorGlyphRun`  => ` IDWriteColorGlyphRunEnumerator`

[* Format]
	http://mrxray.on.coocan.jp/Delphi/Others/Emoji.htm

DirectWrite get_text_size
	http://bubibinba.blogspot.com/2012/10/drawtext.html
