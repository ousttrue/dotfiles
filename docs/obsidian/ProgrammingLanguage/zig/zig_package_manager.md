[[zig]] [[zon]]
[[zig_build_sytem]]

[Package Manager · GitHub](https://github.com/ziglang/zig/projects/4)

- [0.11.0 Release Notes ⚡ The Zig Programming Language](https://ziglang.org/download/0.11.0/release-notes.html#Package-Management)

## build.zig.zon

```zig
.{
    .name = "my_package_name",
    .version = "0.1.0",
    .dependencies = .{
        .dep_name = .{
            .url = "https://link.to/dependency.tar.gz",
            .hash = "12200f41f9804eb9abff259c5d0d84f27caa0a25e0f72451a0243a806c8f94fdc433",
        },
    },
}
```


- @2023 06/28 [Zig Package Manager -- WTF is Zon - Zig NEWS](https://zig.news/edyu/zig-package-manager-wtf-is-zon-558e)
- @2023 06/01 [build.zig.zonを使ったZigの新しいパッケージ管理 (Nightly)](https://zenn.dev/funatsufumiya/articles/7760a4688be3a5)
- @2023 02/13[Zig tips: v0.11 std.build API / package manager changes | Hexops' devlog](https://devlog.hexops.com/2023/zig-0-11-breaking-build-changes/)
- @2023 02/03  [introduce Zig Object Notation and use it for the build manifest file (build.zig.zon) by andrewrk · Pull Request #14523 · ziglang/zig · GitHub](https://github.com/ziglang/zig/pull/14523)
- @2023 01/11 [Package Manager MVP by andrewrk · Pull Request #14265 · ziglang/zig · GitHub](https://github.com/ziglang/zig/pull/14265)

# build.zig.zon
`Zig Object Notation`
dependency を定義する？

## definition

```
.{
    .name = "example",
    .version = "0.1.0",
    .dependencies = .{
        .libname = .{
            .url = "https://github.com/InKryption/zig-pm-example-lib/archive/cc58951e5ebf011350b66b8af4d3812e2bbff176.tar.gz",
            .hash = "1220e42732bd08f861758aee9166cae8b42e83d899725e6e4553e3e54f7bd4b59445",
        },
    },
}
```

## use

```zig
    const example_dep = b.dependency("libname", .{ // <== as declared in build.zig.zon
        .target = target, // the same as passing `-Dtarget=<...>` to the library's build.zig script
        .optimize = optimize, // ditto for `-Doptimize=<...>`
    });
    const baz_mod = example_dep.artifact("baz"); // <== ditto
    exe.linkLibrary(baz_mod);
    const foo_mod = example_dep.module("foo"); // <== as declared in the build.zig of the dependency
    exe.addModule("example-lib", foo_mod);
```

- root に新しいバージョンの `build.zig`があるライブラリを利用可能ぽい。
[leroycep (leroycep) / Repositories · GitHub](https://github.com/leroycep?tab=repositories)

# libs
root に `build.zig` があれば動く？
- [GitHub - InKryption/zig-pm-example-app](https://github.com/InKryption/zig-pm-example-app)
- [GitHub - InKryption/zig-pm-example-lib](https://github.com/InKryption/zig-pm-example-lib)

- [GitHub - locriacyber/mimalloc-zig: Mimalloc bindings for zig](https://github.com/locriacyber/mimalloc-zig)
- [GitHub - star-tek-mb/zig-tray: Create tray applications with zig](https://github.com/star-tek-mb/zig-tray)

- [json/README.md at 7aee46311bfd1625f6641914c26a49e8d3085880 · getty-zig/json · GitHub](https://github.com/getty-zig/json/blob/7aee46311bfd1625f6641914c26a49e8d3085880/README.md)
