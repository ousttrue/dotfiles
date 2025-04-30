https://github.com/silbinarywolf/zig-android-sdk

```sh
> zig build -Dtarget=aarch64-linux-android

=> zig-out/bin/minimal.apk
```

# ANDROID_HOME

`%LOCALAPPDATA%\Local\Android\Sdk`

# JAVA_HOME

`D:/Program Files/Android/Android Studio/jbr`

# build

```zig
        const android_tools = android.Tools.create(b, .{
            .api_level = .android14,
            // ${ENV:ANDROID_HOME}/build_tools
            .build_tools_version = "35.0.0",
            // ${ENV:ANDROID_HOME}/ndk
            // .ndk_version = "27.0.12077973",
            .ndk_version = "27.1.12297006",
        });
```

`zig-android-sdk/src/androidbuild/tools.zig`

```zig
        // Get commandline tools path
        // - 1st: $ANDROID_HOME/cmdline-tools/bin
        // - 2nd: $ANDROID_HOME/tools/bin
        const cmdline_tools_path = cmdlineblk: {
            const cmdline_tools = b.pathResolve(
              // add latest                                      👇
              &[_][]const u8{ android_sdk_path, "cmdline-tools", "latest", "bin" });
```
