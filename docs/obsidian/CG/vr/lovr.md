[[OpenXR]] [[Love2D]]
[[lua]]

[LÖVR](https://lovr.org/docs/Getting_Started)
- [GitHub - bjornbytes/lovr: Lua Virtual Reality Framework](https://github.com/bjornbytes/lovr)
- [GitHub - bjornbytes/lovr-docs: Documentation for LÖVR](https://github.com/bjornbytes/lovr-docs)

# Version
## 0.16
vulkan
standard 未実装？
## 0.15
スタンドアロンの lua から動くようにして lua のデバッガをアタッチできないか？

# build

# lua
`.vscode/settings.json`
```json
    "Lua.workspace.library": [
        "${3rd}/lovr/library"
    ],
```

# Headset
## Desktop
glfw window

`src\api\l_headset.c`
```c
static int l_lovrHeadsetUpdate(lua_State* L);
```
👇
`src\modules\headset\headset_desktop.c`
```c
struct {
  float pitch;
  float yaw;
} state;

static double desktop_update(void) {
}
```

# graphics
- [LÖVR](https://lovr.org/docs/lovr.graphics)
- [LÖVR](https://lovr.org/docs/Pass)

# build for Quest

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
        "ANDROID_KEY_PASS": "pass:android",
    },
}
```

# lodr
- [GitHub - bjornbytes/lodr: Live-reload wrapper for Lovr](https://github.com/bjornbytes/lodr)

# lite-lovr
- [GitHub - jmiskovic/lite-lovr: A lightweight text editor written in Lua](https://github.com/jmiskovic/lite-lovr)

# lovr-ui
- [GitHub - immortalx74/lovr-ui: An immediate mode VR GUI library for LÖVR](https://github.com/immortalx74/lovr-ui)
- [GitHub - bjornbytes/lovr-ui](https://github.com/bjornbytes/lovr-ui)

# lovr-pointer
- [GitHub - bjornbytes/lovr-pointer: Point at objects in VR](https://github.com/bjornbytes/lovr-pointer)

# lovr-mouse
- [GitHub - bjornbytes/lovr-mouse: A mouse module for LÖVR](https://github.com/bjornbytes/lovr-mouse)

# lovr-keyboard
- [GitHub - bjornbytes/lovr-keyboard: Keyboard support for LÖVR](https://github.com/bjornbytes/lovr-keyboard)

# lovr-procmesh
- [GitHub - jmiskovic/lovr-procmesh: Generation of mesh primitives and constructive solid geometry operations](https://github.com/jmiskovic/lovr-procmesh)

# plugins
- [LÖVR](https://lovr.org/docs/Plugins)
## Network
[[lua_socket]]
- [GitHub - brainrom/lovr-luasocket: Cmake-buildable libluasocket for LOVR](https://github.com/brainrom/lovr-luasocket)
