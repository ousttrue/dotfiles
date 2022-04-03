Font metrics
#DirectWrite
#typography
#font

	https://docs.microsoft.com/ja-jp/dotnet/framework/winforms/advanced/how-to-obtain-font-metrics
	https://docs.microsoft.com/en-us/windows/desktop/DirectWrite/glyphs-and-glyph-runs#glyph-runs
	https://creativemarket.com/blog/10-typography-terms-every-designer-should-know
	[https://www.cresco.co.jp/blog/entry/91/ Java の Font 周りの比較的ディープな話(前編)]
	[https://www.cresco.co.jp/blog/entry/103/ Java の Font 周りの比較的ディープな話(後編)]

[*** Glyph]
	https://www.freetype.org/freetype2/docs/glyphs/glyphs-3.html
	http://pawlan.com/monica/articles/texttutorial/other.html
	bounds

[* Vertical]
	baseline
	ascent
	descent
 leading

[* Horizontal] 
	advance


DirectWrite get_text_size
	http://bubibinba.blogspot.com/2012/10/drawtext.html

[*** designUnits]
[DWRITE_GLYPH_METRICS https://docs.microsoft.com/en-us/windows/desktop/api/dwrite/ns-dwrite-dwrite_glyph_metrics]
	https://docs.microsoft.com/en-us/windows/desktop/DirectWrite/glyphs-and-glyph-runs#glyph-runs

[* To EM]
	https://stackoverflow.com/questions/42659511/i-am-getting-a-different-font-height-from-directwrite-font-text-metric-than-i-re
`DWRITE_FONT_METRICS.designUnitsPerEm`

[* DWRITE_FONT_METRICS with ID2D1RenderTarget::DrawString rect]
rectの幅が足りないと改行されるのだが
