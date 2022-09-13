const std = @import("std");

const c_pkg = std.build.Pkg{
    .name = "c",
    .source = .{ .path = "c.zig" },
};

const LUA_SOURCE = [_][]const u8{
    "lua/lapi.c",
    "lua/lcode.c",
    "lua/lctype.c",
    "lua/ldebug.c",
    "lua/ldo.c",
    "lua/ldump.c",
    "lua/lfunc.c",
    "lua/lgc.c",
    "lua/llex.c",
    "lua/lmem.c",
    "lua/lobject.c",
    "lua/lopcodes.c",
    "lua/lparser.c",
    "lua/lstate.c",
    "lua/lstring.c",
    "lua/ltable.c",
    "lua/ltm.c",
    "lua/lundump.c",
    "lua/lvm.c",
    "lua/lzio.c",
    "lua/ltests.c",
    "lua/lauxlib.c",
    "lua/lbaselib.c",
    "lua/ldblib.c",
    "lua/liolib.c",
    "lua/lmathlib.c",
    "lua/loslib.c",
    "lua/ltablib.c",
    "lua/lstrlib.c",
    "lua/lutf8lib.c",
    "lua/loadlib.c",
    "lua/lcorolib.c",
    "lua/linit.c",
    // "lua/lua.c",
    "src/lua.c",
};

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("lua", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);

    exe.addPackage(c_pkg);
    exe.linkLibC();
    exe.addIncludePath("lua");
    exe.addCSourceFiles(&LUA_SOURCE, &.{});

    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}
