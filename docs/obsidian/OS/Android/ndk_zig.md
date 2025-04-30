[[zig]]

- [GitHub - MasterQ32/ZigAndroidTemplate: This repository contains a example on how to create a minimal Android app in Zig.](https://github.com/MasterQ32/ZigAndroidTemplate)

- [GitHub - MasterQ32/zero-graphics: Application framework based on OpenGL ES 2.0. Runs on desktop machines, Android phones and the web](https://github.com/MasterQ32/zero-graphics)

# so の作り方

```zig
    const app_module = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("dummy.zig"),
    });

/// Deprecated: use `b.addLibrary(.{ ..., .linkage = .dynamic })` instead.
pub fn addSharedLibrary(b: *Build, options: SharedLibraryOptions) *Step.Compile {
    if (options.root_module != null and options.target != null) {
        @panic("`root_module` and `target` cannot both be populated");
    }
    return .create(b, .{
        .name = options.name,
        .root_module = options.root_module orelse b.createModule(.{
            .target = options.target orelse @panic("`root_module` and `target` cannot both be null"),
            .optimize = options.optimize,
            .root_source_file = options.root_source_file,
            .link_libc = options.link_libc,
            .single_threaded = options.single_threaded,
            .pic = options.pic,
            .strip = options.strip,
            .unwind_tables = options.unwind_tables,
            .omit_frame_pointer = options.omit_frame_pointer,
            .sanitize_thread = options.sanitize_thread,
            .error_tracing = options.error_tracing,
            .code_model = options.code_model,
        }),
        .kind = .lib,
        .linkage = .dynamic,
        .version = options.version,
        .max_rss = options.max_rss,
        .use_llvm = options.use_llvm,
        .use_lld = options.use_lld,
        .zig_lib_dir = options.zig_lib_dir,
        .win32_manifest = options.win32_manifest,
    });
}
```

