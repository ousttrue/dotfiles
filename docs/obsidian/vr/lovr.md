[[OpenXR]]
[[lua]]

- [GitHub - bjornbytes/lovr: Lua Virtual Reality Framework](https://github.com/bjornbytes/lovr)

# run Quest
- [LÖVR](https://lovr.org/docs/Getting_Started_(Quest))

# build for Quest
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
        "ANDROID_KEY_PASS": "pass:android",
    },
}
```
