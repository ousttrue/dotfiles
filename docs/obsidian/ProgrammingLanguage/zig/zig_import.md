backup

# 特殊な @import
## @import("root")

エントリーポイントの struct を得る。
`std.log` のカスタマイズで使われている。

## @import("builtin")

```zig
const exe_extension = builtin.target.exeFileExt();

if (builtin.os.tag == .windows) {
}
```

## @import("build_options") 

`build_options` は `build.zig` で指定できるので決まった名前ではない。

`zls` の build.zig を参照。

```zig:build.zig
    const exe_options = b.addOptions();
    exe.addOptions("build_options", exe_options);

    exe_options.addOption(
        shared.ZigVersion,
        "data_version",
        b.option(shared.ZigVersion, "data_version", "The Zig version your compiler is.") orelse .master,
    );

    exe_options.addOption(
        std.log.Level,
        "log_level",
        b.option(std.log.Level, "log_level", "The Log Level to be used.") orelse .info,
    );
```

```zig:src/main.zig
const build_options = @import("build_options");

const log_level = build_options.log_level; // <- zig build の引数を引っ張ってこれる？
```
