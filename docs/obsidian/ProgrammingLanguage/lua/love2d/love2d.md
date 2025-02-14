- [LÖVE - Free 2D Game Engine](https://love2d.org/)

  - [LOVE](https://love2d.org/wiki/Main_Page)

- https://github.com/brigid-jp/love2d-excersises/tree/master/01
- https://medium.com/zabu
- https://github.com/brigid-jp/brigid/wiki
- https://github.com/JosefAlbers/TerrainZigger

# articles

- [LÖVE(Love2D) プログラミング入門](https://love2d-programming.com/)
- @2021 [Love2D(Lua)でゲームをつくる](https://zenn.dev/m9m/scraps/52a88a63cdd1f4) [[luajit]] [[luarocks]]
- [GitHub - camchenry/shaderview: A GLSL shader development tool for the LÖVE game framework.](https://github.com/camchenry/shaderview)
- [Lead Haul by YouDoYouBuddy](https://youdoyoubuddy.itch.io/lead-haul)
- [GitHub - excessive/love3d: A 3D extension for LÖVE 0.10](https://github.com/excessive/love3d/)
- [GitHub - CapsAdmin/goluwa: game engine and framework written in luajit](https://github.com/CapsAdmin/goluwa)
- [GitHub - CelestialCartographers/Loenn: A Visual Map Maker and Level Editor for the game Celeste but better than the other one](https://github.com/CelestialCartographers/Loenn)
- [GitHub - gtrogers/Cute: Micro unit testing for Love2d](https://github.com/gtrogers/Cute)

## dll

- https://love2d.org/forums/viewtopic.php?t=86145
- [Loadable love in Lua · GitHub](https://gist.github.com/markandgo/dfa7d4c1fc7b81da2ed5)

## love.run

mainloop のオーバーライド

- https://love2d.org/wiki/love.run_(%E6%97%A5%E6%9C%AC%E8%AA%9E)

## 3D

- [GitHub - rozenmad/Menori: Library for 3D rendering with LÖVE.](https://github.com/rozenmad/Menori)
  `glTF loader`, `GPU skinning`

- [GitHub - 3dreamengine/3DreamEngine: 3DreamEngine is an _awesome_ 3d engine for LÖVE.](https://github.com/3dreamengine/3DreamEngine)
  `glTF`, `vox`,

- [GitHub - groverburger/g3d: Simple and easy 3D engine for LÖVE.](https://github.com/groverburger/g3d)
  `samples`

- [GitHub - excessive/love3d-demos: Various LÖVE3D demos and examples to get you started.](https://github.com/excessive/love3d-demos)

## morphtarget

- [GitHub - RNavega/2DMeshAnimation-Love: LÖVE (Love2D) example of an animated 2D mesh](https://github.com/RNavega/2DMeshAnimation-Love)

# version

[Version History - LOVE](https://love2d.org/wiki/Version_History)

## 12.0(dev) @2024

- https://love2d.org/wiki/12.0
- https://github.com/love2d/love/milestone/1

## 11.5 @202312

## 11.4 @202201

# project

- 📁root
  - main.lua (entry point)

```sh
# launch
> love . # folder arg
```

- [GitHub - camchenry/Love2D-Template: A game development template for LÖVE.](https://github.com/camchenry/Love2D-Template)
- [GitHub - dschneider/love-boilerplate: A boilerplate template for the awesome LÖVE (love2d) framework](https://github.com/dschneider/love-boilerplate)

# vscode

custom interpleter

```json:.vscode/settings.json
{
      "Lua.diagnostics.globals": ["love"],
      "Lua.runtime.version": "LuaJIT",
      "Lua.workspace.library": [ "${3rd}/love2d/library" ]
}
```

# build

## Ubuntu

- libsdl2-dev
- libmodplug-dev
- libtheora-dev
- libmpg123-dev

## Windows

- [GitHub - love2d/megasource: Megasource is a CMake-buildable collection of all LÖVE dependencies.](https://github.com/love2d/megasource)

# gui

- [Reference](http://airstruck.github.io/luigi/doc/classes/Widget.html)
- [GitHub - vrld/suit: Immediate Mode GUI library for LÖVE](https://github.com/vrld/SUIT)
