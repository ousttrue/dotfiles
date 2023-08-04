[[peg]] [[cyber]]

[Home ⚡ Zig Programming Language](https://ziglang.org/)

- [GitHub - nrdmn/awesome-zig](https://github.com/nrdmn/awesome-zig)
- [[全編無料] 他言語習得者がとりあえず使えるようになるZig](https://zenn.dev/drumato/books/learn-zig-to-be-a-beginner)

# Version
## 0.12 development
- [[zig_build_sytem]] [0.11.0 Release Notes ⚡ The Zig Programming Language](https://ziglang.org/download/0.11.0/release-notes.html#Build-System)

## 0.11
- @202308 [0.11.0 Milestone · GitHub](https://github.com/ziglang/zig/milestone/17)

## 0.10.1
## 0.10.0
async 動かない
[async/await/suspend/resume · Issue #6025 · ziglang/zig · GitHub](https://github.com/ziglang/zig/issues/6025)

# [[lsp]]
- [GitHub - zigtools/zls: Zig LSP implementation + Zig Language Server](https://github.com/zigtools/zls)

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
