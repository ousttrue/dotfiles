[[lua]] [[jit]]

- @2022 [LunarML進捗・2022年7月：LuaJIT対応など | 雑記帳](https://blog.miz-ar.info/2022/07/lunarml-progress-jul2022/)
- @2022 [LuaJITの64ビット整数](https://zenn.dev/mod_poppo/articles/luajit-int64)
- @2020 [【AviUtl】LuaJITを導入して動作を高速化しよう！【拡張編集】 - AKETAMA OFFICIAL BLOG](https://aketama.work/aviutl-luajit)

# Version

## 2.1.0-beta3

# LuaJIT Remake

- @2022 https://sillycross.github.io/2022/11/22/2022-11-22/
- [luajit-remakeを試してみた &#183; hnakamur's blog](https://hnakamur.github.io/blog/2022/12/28/tried-luajit-remake/)

# DynASM

- [DynASM](https://luajit.org/dynasm.html)
- [The Unofficial DynASM Documentation](https://corsix.github.io/dynasm-doc/)

# FFI

- @2020 [LuaJIT FFIでモジュールを書く時のハウツー · hnakamur's blog](https://hnakamur.github.io/blog/2020/03/21/how-to-write-luajit-ffi-module/)

# build

gcc/clang/msvc ビルド可能だが、
MinGWを非MSYS環境で使う場合にこける？
neovim のビルドのため 非MSYS の MinGW でビルドしたい。

- LLVM-MInGW(ucrt) + meson でできた https://github.com/franko/luajit

```
> meson setup builddir --prefix %USERPROFILE%/build/llvm-mingw --buildtype=release
> meson install -C builddir
```

# build.zig

- https://nathancraddock.com/blog/complex-luajit/

## luajit

- https://github.com/ziglang/zig/issues/14089
