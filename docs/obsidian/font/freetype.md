# build

関連ライブラリーの依存について

- https://stackoverflow.com/questions/41767193/how-do-i-build-cairo-harfbuzz

| lib        | dep                        |
| ---------- | -------------------------- |
| cairo      | fontconfig, harfbuzz(test) |
| fontconfig | freetype, harfbuzz(test)   |
| freetype   | harfbuzz                   |
| harfbuzz   | freetype                   |
| pango      |

```sh
> meson setup builddir --prefix "$(pwd)/prefix" -Ddefault_library=static --native-file .\clang.ini -Dglib:sysprof=disabled -Dglib:introspection=disabled
# pango
  Subprojects
    cairo          : YES 1 warnings
    freetype2      : YES 1 warnings (from harfbuzz)
    fribidi        : YES
    glib           : YES
    gvdb           : YES (from glib)
    harfbuzz       : YES 7 warnings
    libffi         : YES (from glib)
    libpng         : YES (from harfbuzz => freetype2)
    pcre2          : YES (from glib)
    pixman         : YES (from cairo)
    proxy-libintl  : YES (from glib)
    sysprof        : YES 1 warnings (from glib)
    zlib           : YES (from glib)
```

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
