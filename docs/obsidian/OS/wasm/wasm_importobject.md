# importObject

## freestanding

- libc などなし
- importObject は空で OK

```
zig\0.13.0\files\lib\std\posix.zig|121 col 24 error| root struct of file 'c' has no member named 'fd_t'
```

```zig
export fn add(a: i32, b: i32) i32 {
    return a + b;
}
```

cppの場合

```cpp
#define export __attribute__((visibility("default")))
extern "C" export int add(int a, int b) { return a + b; }
```

```zig

pub fn build_exe(
    b: *std.Build,
    optimize: std.builtin.OptimizeMode,
) *std.Build.Step.Compile {
    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = b.resolveTargetQuery(.{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        }),
        .optimize = optimize,
        .link_libc = false, // 👈
    });
    exe.entry = .disabled;
    exe.rdynamic = true;
```

```js
const importObject = {};
const response = await fetch("zig-out/bin/main.wasm");
const results = await WebAssembly.instantiateStreaming(response, importObject);
console.log(results);
console.log(results.instance.exports.add(1, 2));
```

## wasi

おそらく c の範囲。c++ は `emsdk` を使う。

## emscripten

おそらく c の範囲。c++ は `emsdk` を使う。

## importObject.imports

# WebAssembly.instantiate()

https://developer.mozilla.org/ja/docs/WebAssembly/JavaScript_interface/instantiate_static
