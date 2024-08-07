https://ziglang.org/learn/build-system/

```zig
const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_source_file = b.path("hello.zig"),
        .target = b.host,
    });

    b.installArtifact(exe);
}
```

# Options for Conditional Compilation

`build.zig` から `main.zig` に comptime 定数を送り込む。

# Generating Files

## from tool

```build.zig
const output = tool_step.addOutputFileArg("word.txt");
b.addInstallFileWithDir(output, .prefix, "word.txt");
```

## from tool (make tool by zig)

# Generating Zig Source Code

- `has_side_effects` @2024 [Zigでビルド時にZig依存を作る](https://zenn.dev/mkpoli/articles/620223f8054b03)

```build.zig
const output = tool_step.addOutputFileArg("person.zig");
exe.root_module.addAnonymousImport("person", .{
  .root_source_file = output,
});
```

# Dealing With One or More Generated Files

# Mutating Source Files in Place

```

```
