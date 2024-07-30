# Font metrics

[[DirectWrite]]
[[freetype]]
[[stb_truetype]]
[[typography]]
[[font]]

- [方法: フォント メトリックを取得する - Windows Forms .NET Framework | Microsoft Docs](https://docs.microsoft.com/ja-jp/dotnet/framework/winforms/advanced/how-to-obtain-font-metrics)
- [Glyphs and Glyph Runs - Win32 apps | Microsoft Docs](https://docs.microsoft.com/en-us/windows/desktop/DirectWrite/glyphs-and-glyph-runs#glyph-runs)

[10 Typography Terms Every Designer Should Know - Creative Market Blog](https://creativemarket.com/blog/10-typography-terms-every-designer-should-know)
[Java の Font 周りの比較的ディープな話(前編)](https://www.cresco.co.jp/blog/entry/91/)
[Java の Font 周りの比較的ディープな話(後編)](https://www.cresco.co.jp/blog/entry/103/)

## Glyph

- [FreeType Glyph Conventions | Glyph Metrics](https://www.freetype.org/freetype2/docs/glyphs/glyphs-3.html)
- [Tutorial on Styled Text](http://pawlan.com/monica/articles/texttutorial/other.html)

- baseline
- ascent
- descent
- leading
- advance

## designUnits

[DWRITE_GLYPH_METRICS https://docs.microsoft.com/en-us/windows/desktop/api/dwrite/ns-dwrite-dwrite_glyph_metrics]
https://docs.microsoft.com/en-us/windows/desktop/DirectWrite/glyphs-and-glyph-runs#glyph-runs

[* To EM]
https://stackoverflow.com/questions/42659511/i-am-getting-a-different-font-height-from-directwrite-font-text-metric-than-i-re
`DWRITE_FONT_METRICS.designUnitsPerEm`

[* DWRITE_FONT_METRICS with ID2D1RenderTarget::DrawString rect]
rectの幅が足りないと改行されるのだが
