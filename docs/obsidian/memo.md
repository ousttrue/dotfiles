# todo

## OpenXR + Vulkan

- https://github.com/ousttrue/hello_vulkan

Windows, Android, OpenXR まで vulkan の動確できた。

hello_xr の refactoring

LOVR では

- https://github.com/ousttrue/openxr_samples
- https://github.com/ousttrue/xrdesk
- https://github.com/ousttrue/XRStreamer
- https://github.com/ousttrue/hello_openxr
- `x` https://github.com/ousttrue/xrfw

# todo.bak

- imgviewer(single binary. go?)

quest3 + [lovr](https://github.com/bjornbytes/lovr) で MixedReality + handtracking したい。

quest3 向きに MR 部分を改造。

素の OpenXR プロジェクトを調査。

- zig build: https://github.com/meta-quest/Meta-OpenXR-SDK

# zig-sokol

- https://github.com/ousttrue/zigltf
  - https://github.com/ousttrue/rowmath
    - [x] https://github.com/ousttrue/emsdk-zig
    - [ ] https://github.com/ousttrue/sokol-zig

# memo

| tool       | content  |         |
| ---------- | -------- | ------- |
| zig        | graphics | sokol   |
| bun / vite | ssg      | minista |

|             | **multi**         | Windows   | git bash       | msys     | wsl      | Linux    |
| ----------- | ----------------- | --------- | -------------- | -------- | -------- | -------- |
| term        | WezTerm           | WezTerm   | mintty         | mintty   | WezTerm  | WezTerm  |
| CHOST       | **CROSS**         |           | x86_64-pc-msys |          |          |
| fep         | nyagos-skk ?      |           |                | uim-fep  | uim-fep  |
| muxer       | WezTerm           | WezTerm   |                | tmux     | tmux     | tmux     |
| shell       | nyagos            | nyagos    | bash           | zsh      | zsh      | zsh      |
| cp,mv,rm... | binutils / buybox | busybox64 | binutils       | binutils | binutils | binutils |
| editor      | nvim              | vim       | nvim(msys)     | nvim     | nvim     |

- offline dev
- simple desktop
- more tui(w3m)
- desktop vr

  - handtracking
  - cu3e

- font

# zig + sokol + imgui & wasm

- https://github.com/floooh/sokol-zig
- https://github.com/floooh/sokol-zig-imgui-sample/

emscripten build ができる(Windowsではビルドに失敗することに注意)

```zig:build.zig
const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dep_sokol = b.dependency("sokol", .{
        .target = target,
        .optimize = optimize,
        .with_sokol_imgui = true,
    });
    const dep_cimgui = b.dependency("cimgui", .{
        .target = target,
        .optimize = optimize,
    });
    // inject the cimgui header search path into the sokol C library compile step
    const cimgui_root = dep_cimgui.namedWriteFiles("cimgui").getDirectory();
    dep_sokol.artifact("sokol_clib").addIncludePath(cimgui_root);

    const exe = b.addExecutable(.{
        .name = "zigwrap",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("sokol", dep_sokol.module("sokol"));
    exe.step.dependOn(buildShader(b, target, "src/cube.glsl"));
    exe.root_module.addImport("cimgui", dep_cimgui.module("cimgui"));
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    b.step("run", "Run the app").dependOn(&run_cmd.step);
}

// a separate step to compile shaders, expects the shader compiler in ../sokol-tools-bin/
fn buildShader(
    b: *std.Build,
    target: std.Build.ResolvedTarget,
    comptime shader: []const u8,
) *std.Build.Step {
    const sokol_tools_bin_dir = "../../floooh/sokol-tools-bin/bin/";
    const optional_shdc: ?[:0]const u8 = comptime switch (builtin.os.tag) {
        .windows => "win32/sokol-shdc.exe",
        .linux => "linux/sokol-shdc",
        .macos => if (builtin.cpu.arch.isX86()) "osx/sokol-shdc" else "osx_arm64/sokol-shdc",
        else => null,
    };
    if (optional_shdc == null) {
        std.log.warn("unsupported host platform, skipping shader compiler step", .{});
        return;
    }
    const shdc_path = sokol_tools_bin_dir ++ optional_shdc.?;
    const shdc_step = b.step("shaders", "Compile shaders (needs ../../floooh/sokol-tools-bin)");
    const glsl = if (target.result.isDarwin()) "glsl410" else "glsl430";
    const slang = glsl ++ ":metal_macos:hlsl5:glsl300es:wgsl";
    const cmd = b.addSystemCommand(&.{
        shdc_path,
        "-i",
        shader,
        "-o",
        shader ++ ".zig",
        "-l",
        slang,
        "-f",
        "sokol_zig",
    });
    shdc_step.dependOn(&cmd.step);
    return shdc_step;
}
```
