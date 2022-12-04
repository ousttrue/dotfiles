[[peg]]

[Home ⚡ Zig Programming Language](https://ziglang.org/)

- [GitHub - nrdmn/awesome-zig](https://github.com/nrdmn/awesome-zig)

## [[lsp]]
- [GitHub - zigtools/zls: Zig LSP implementation + Zig Language Server](https://github.com/zigtools/zls)

## d3d11
- [GitHub - michal-z/zig-gamedev: Building game development ecosystem for @ziglang!](https://github.com/michal-z/zig-gamedev)

imgui は `@cImport`

# OpenGL
- [GitHub - mypalmike/zigNeHe: NeHe OpenGL tutorials, ported to the Zig language.](https://github.com/mypalmike/zigNeHe)


## graphics

- <https://git.yx.mk/hexops/mach>

## allocator
- [Allocator ってなに (Zig Documentation) - MemoBook](https://scrapbox.io/tamago324vim/Allocator_%E3%81%A3%E3%81%A6%E3%81%AA%E3%81%AB_(Zig_Documentation))

# build
- [Zig Build - Gamedev Guide](https://ikrima.dev/dev-notes/zig/zig-build/)
- [@import() and Packages - Zig NEWS](https://zig.news/mattnite/import-and-packages-23mb)


# 0.9
- [Allocgate is coming in Zig 0.9, and you will have to change your code](https://pithlessly.github.io/allocgate.html)


## zls

```zig
var tree = try std.zig.parse(self.allocator, text);
```

## webgl

```
zig build-lib -target wasm32-freestanding test.c -lc
```

```zig
exe.setTarget(.{ .cpu_arch = .wasm32, .os_tag = .freestanding });
```

- ⚡ [GitHub - fabioarnold/hello-webgl: Hello WebGL in Zig](https://github.com/fabioarnold/hello-webgl)
-  [GitHub - raulgrell/zig-wasm-webgl: Using Zig and WebGL](https://github.com/raulgrell/zig-wasm-webgl)
