# build

- gobject-introspection

## freetype

[FreeType Glyph Conventions | Glyph Metrics](https://freetype.org/freetype2/docs/glyphs/glyphs-3.html)

```c
struct FT_GlyphSlotRec
{
    FT_Bitmap         bitmap;
    FT_Int            bitmap_left;
    FT_Int            bitmap_top;
};
```

## harfbuzz

https://stackoverflow.com/questions/41767193/how-do-i-build-cairo-harfbuzz

- Freetype --with-harfbuzz=no
- HarfBuzz
- Freetype --with-harfbuzz=yes
- fontconfig.
- Cairo.

## fontconfig

## cairo

- freetype
- pixman

## pango

最後にビルド？

- https://github.com/ImageMagick/pango/blob/main/meson.build

  - cairo
  - freetype
  - fontconfig
  - harfbuzz

https://stackoverflow.com/questions/21790759/building-pango-with-cairo-support

- Build and install FreeType
- Build and install fontconfig
- Build and install Cairo (after ./configure please make sure freetype and fontconfig are found)
- Build and install Harfbuzz
- Build and install Pango
