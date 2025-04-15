# cmake

## submodules

recursive update を避けること。
recursive すると巨大で終わらない。
`ghq get` は注意。

### glfw

- required for DesktopWindow

### glslang & vulkan-headers

- required

### joltc

- option `-DLOVR_ENABLE_PHYSICS=OFF`

### lua | luajit

- required `-DLOVR_USE_LUAJIT=OFF` (use lua)

### msdfgen

- required

### openxr

- option `-DLOVR_USE_OPENXR=OFF` (use glfw only)

### traycy

- option

# Desktop

```sh
> cmake -S . -B build -G Ninja -DLOVR_ENABLE_PHYSICS=OFF -DLOVR_USE_LUAJIT=OFF -DLOVR_USE_OPENXR=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=1
> cmake --build build
> ./build/lovr.exe test
      headset
                PASS isVisible
                PASS isFocused
                PASS isMounted
```

# Android

`-U_FORTIFY_SOURCE`

- [Android Developers Blog: FORTIFY in Android](https://android-developers.googleblog.com/2017/04/fortify-in-android.html)
- [[question] What's the correct way to disable FORTIFY_SOURCE? · Issue #1371 · android/ndk · GitHub](https://github.com/android/ndk/issues/1371)

`.vscode/settings.json`

```json
{
  "cmake.configureSettings": {
    "CMAKE_TOOLCHAIN_FILE": "${env:ANDROID_HOME}/ndk/21.4.7075529/build/cmake/android.toolchain.cmake",
    "CMAKE_EXPORT_COMPILE_COMMANDS": "ON",
    "ANDROID": "ON",
    "ANDROID_SDK": "${env:ANDROID_HOME}",
    "ANDROID_BUILD_TOOLS_VERSION": "30.0.3",
    "ANDROID_PLATFORM": "android-26",
    "ANDROID_NATIVE_API_LEVEL": "26",
    "ANDROID_ABI": "arm64-v8a",
    "CMAKE_ANDROID_ARCH_ABI": "arm64-v8a",
    "LOVR_USE_LUAJIT": "OFF",
    "ANDROID_KEYSTORE": "${env:USERPROFILE}/.android/debug.keystore",
    "ANDROID_KEYSTORE_PASS": "pass:android",
    "ANDROID_KEY_PASS": "pass:android"
  }
}
```

# 構成
