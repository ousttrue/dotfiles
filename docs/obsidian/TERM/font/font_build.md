# font 関連ライブラリーのビルド

- https://stackoverflow.com/questions/41767193/how-do-i-build-cairo-harfbuzz

> There is also a circular dependency between freetype and HarfBuzz

```sh
Build Freetype using:

./configure --prefix=${PREFIX} --host=x86_64-w64-mingw32 --with-sysroot=/usr/x86_64-w64-mingw32 --with-harfbuzz=no

Build HarfBuzz using:

./configure --prefix=${PREFIX} --host=x86_64-w64-mingw32 --with-fontconfig=no --with-cairo=no --with-sysroot=/usr/x86_64-w64-mingw32

Build Freetype using:

./configure --prefix=${PREFIX} --host=x86_64-w64-mingw32 --with-sysroot=/usr/x86_64-w64-mingw32 --with-harfbuzz=yes

Build fontconfig.

Build Cairo.
```

