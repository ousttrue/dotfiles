[[OpenXR]] [[Love2D]]
[[lua]]

[LÖVR](https://lovr.org/docs/Getting_Started)

- [GitHub - bjornbytes/lovr: Lua Virtual Reality Framework](https://github.com/bjornbytes/lovr)

# Version

## 0.17

@2023 https://lovr.org/docs/PassthroughMode

## 0.16

vulkan
standard 未実装？

## 0.15

スタンドアロンの lua から動くようにして lua のデバッガをアタッチできないか？

# build 構成

# non VR

カメラ？

## default

- left drag
- wasd

# init

`main.lua`

````lua
local model

local customVertex = [[
    vec4 lovrmain()
    {
        return Projection * View * Transform * VertexPosition;
    }
]]

local defaultFragment = [[
    Constants {
        vec4 ambience;
        vec4 lightColor;
        vec3 lightPos;
    };

    vec4 lovrmain()
    {
        //diffuse
        vec3 norm = normalize(Normal);
        vec3 lightDir = normalize(lightPos - PositionWorld);
        float diff = max(dot(norm, lightDir), 0.0);
        vec4 diffuse = diff * lightColor;

        vec4 baseColor = Color * getPixel(ColorTexture, UV);
        return baseColor * (ambience + diffuse);
    }
]]

local shader = lovr.graphics.newShader(customVertex, defaultFragment, {})

function lovr.load()
  -- Load a 3D model
  model = lovr.graphics.newModel "monkey.obj"

  -- Use a dark grey background
  lovr.graphics.setBackgroundColor(0.2, 0.2, 0.2)
end

function lovr.draw(pass)
  -- Draw the model
  pass:setColor(1, 1, 1)
  pass:setShader(shader)
  pass:send("ambience", { 0.2, 0.2, 0.2, 1.0 })
  pass:send("lightColor", { 1.0, 1.0, 1.0, 1.0 })
  pass:send("lightPos", { 2.0, 5.0, 0.0 })
  pass:draw(model, -0.5, 1, -3)

  -- Draw a red cube using the "cube" primitive
  pass:setColor(1, 0, 0)
  pass:cube(0.5, 1, -3, 0.5, lovr.timer.getTime())

  return false
end```

`.luarc.json`
```json
{
  "runtime.version": "LuaJIT",
  "runtime.special": {
    "love.filesystem.load": "loadfile"
  },
  "runtime.path": ["libs/?.lua", "libs/?/init.lua"],
  "workspace.library": ["${3rd}/lovr/library"],
  "format.enable": false,
  "format.defaultConfig": {
    "indent_style": "space",
    "indent_size": "2"
  },
  "diagnostics.disable": ["empty-block", "unused-local", "unused-vararg"]
}
````

# samples

- [GitHub - bjornbytes/lovr-docs: Documentation for LÖVR](https://github.com/bjornbytes/lovr-docs)
- [GitHub - sophiabaldonado/layout: VR world builder](https://github.com/sophiabaldonado/layout)

# webxr

`lovr.wasm`

# LanguageServer

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

- [lovr.graphics LÖVR](https://lovr.org/docs/lovr.graphics)
- [Pass LÖVR](https://lovr.org/docs/Pass)

# build

## Desktop

```sh
# -G Ninja にすると何故か --build で失敗する
cmake -S . -B build
```

## Android

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
- [mermaid-lovr | Mermaid Heavy Industries resources for the Lovr engine](https://mcclure.github.io/mermaid-lovr/)
- https://github.com/immortalx74/lovr-ui

## Network

[[lua_socket]]

- [GitHub - brainrom/lovr-luasocket: Cmake-buildable libluasocket for LOVR](https://github.com/brainrom/lovr-luasocket)
