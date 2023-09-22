[[lua]]

- [LÖVE - Free 2D Game Engine](https://love2d.org/)
	- [LOVE](https://love2d.org/wiki/Main_Page)

- [LÖVE(Love2D) プログラミング入門](https://love2d-programming.com/)
- @2021 [Love2D(Lua)でゲームをつくる](https://zenn.dev/m9m/scraps/52a88a63cdd1f4) [[luajit]] [[luarocks]]

# sample
- [Lead Haul by YouDoYouBuddy](https://youdoyoubuddy.itch.io/lead-haul)
- [GitHub - excessive/love3d: A 3D extension for LÖVE 0.10](https://github.com/excessive/love3d/)
- [GitHub - CapsAdmin/goluwa: game engine and framework written in luajit](https://github.com/CapsAdmin/goluwa)
- [GitHub - CelestialCartographers/Loenn: A Visual Map Maker and Level Editor for the game Celeste but better than the other one](https://github.com/CelestialCartographers/Loenn)

# version
## 11.4
@2022

# project
+ 📁root
	+ main.lua (entry point)
```
# launch
> love . # folder arg
```

# vscode
custom interpleter
```json:.vscode/settings.json
{
      "Lua.diagnostics.globals": [
            "love"
      ],
      "Lua.runtime.version": "LuaJIT",
      "Lua.workspace.library": [
            "${3rd}/love2d/library"
      ]
}
```

# build

## Ubuntu
- libsdl2-dev
- libmodplug-dev
- libtheora-dev
- libmpg123-dev

## Windows
- [Building LÖVE/megasource 2019 (日本語) - LOVE](https://love2d.org/wiki/Building_L%C3%96VE/megasource_2019_(%E6%97%A5%E6%9C%AC%E8%AA%9E))
依存ライブラリーがたくさんあるので、Windows向けの配布がある。

こっちでビルドできる
- [GitHub - love2d/megasource: Megasource is a CMake-buildable collection of all LÖVE dependencies.](https://github.com/love2d/megasource)

# debugger
コマンドライン引数。
`love.dll` が最初から分かれているので、起動スクリプトがあればデバッグできそう？

- `src/modules/love/love.jitsetup.lua`
- `src/modules/love/boot.lua`

改造しないと厳しそう？
- [Love as Lua module - LÖVE](https://love2d.org/forums/viewtopic.php?t=86145)

slandalone lua の `-e` オプションを追加するのが良いか？

`lua local-debug` でデバッグするのがよい。
- [GitHub - tomblind/local-lua-debugger-vscode: Local Lua Debugger for VSCode](https://github.com/tomblind/local-lua-debugger-vscode)

# testing
- [GitHub - gtrogers/Cute: Micro unit testing for Love2d](https://github.com/gtrogers/Cute)

# 3D
- [GitHub - rozenmad/Menori: Library for 3D rendering with LÖVE.](https://github.com/rozenmad/Menori)
`glTF loader`, `GPU skinning`

- [GitHub - 3dreamengine/3DreamEngine: 3DreamEngine is an *awesome* 3d engine for LÖVE.](https://github.com/3dreamengine/3DreamEngine)
`glTF`, `vox`, 

- [GitHub - groverburger/g3d: Simple and easy 3D engine for LÖVE.](https://github.com/groverburger/g3d)
`samples`

- [GitHub - excessive/love3d-demos: Various LÖVE3D demos and examples to get you started.](https://github.com/excessive/love3d-demos)

## morphtarget
- [GitHub - RNavega/2DMeshAnimation-Love: LÖVE (Love2D) example of an animated 2D mesh](https://github.com/RNavega/2DMeshAnimation-Love)

# gui
- [Reference](http://airstruck.github.io/luigi/doc/classes/Widget.html)
- [GitHub - vrld/suit: Immediate Mode GUI library for LÖVE](https://github.com/vrld/SUIT)

# imgui
## cimgui
- [GitHub - apicici/cimgui-love: LÖVE module for Dear ImGui obtained by wrapping cimgui with LuaJIT FFI.](https://github.com/apicici/cimgui-love)
