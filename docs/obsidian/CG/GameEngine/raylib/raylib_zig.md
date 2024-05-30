# raylib `zig-0.12`

本家に入っている？

https://github.com/raysan5/raylib/blob/master/build.zig-out

C のライブラリーとしてビルドできる

```sh
zig build
```

- zig-out
  - include
    - raylib.h
    - raymath.h
    - rlgl.h
  - lib/raylib.lib

```zig
    exe.addIncludePath(b.path("zig-out/include"));
    exe.addLibraryPath(b.path("zig-out/lib"));
    exe.linkSystemLibrary("raylib");
    exe.linkSystemLibrary("gdi32");
    exe.linkSystemLibrary("winmm");
```

```zig
pub const c = @cImport({
    @cInclude("raylib.h");
});
```

# raylib-zig `zig-0.12`

https://github.com/Not-Nik/raylib-zig

`b.installArtifact(exe)` を足してやると `zig-cache` から `zig-out` に来る。

- rcamera.h が無い
- `*const anyopaque` に `null` を渡せなくて困った

# raylib.zig `not zig-0.12`

https://github.com/ryupold/raylib.zig
https://github.com/ryupold/raygui.zig
https://github.com/ryupold/examples-raylib.zig

# 自作

- Cからの移植が楽なようにする
- 大文字小文字, sake_case とか変えない
- Cのソースをローカルに保持
- zig の binder は自動生成
