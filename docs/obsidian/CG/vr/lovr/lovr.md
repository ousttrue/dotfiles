[[OpenXR]] [[Love2D]]
[[lua]]

[LÖVR](https://lovr.org/docs/Getting_Started)

- [GitHub - bjornbytes/lovr: Lua Virtual Reality Framework](https://github.com/bjornbytes/lovr)

# Version

## 0.18 

- @2025 https://github.com/bjornbytes/lovr/releases

## 0.17

- @2023 https://lovr.org/docs/PassthroughMode

## 0.16

vulkan
standard 未実装？

## 0.15

スタンドアロンの lua から動くようにして lua のデバッガをアタッチできないか？

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
