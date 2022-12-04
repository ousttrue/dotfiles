[[lua]]

- [LÖVE - Free 2D Game Engine](https://love2d.org/)
	- [LOVE](https://love2d.org/wiki/Main_Page)

`$ love.exe {MAIN_LUA_FOLDER}`

- [LÖVEのいろは](https://hakolife.net/love2d/)
- [Love2D(Lua)でゲームをつくる](https://zenn.dev/m9m/scraps/52a88a63cdd1f4)

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

# 3D
[GitHub - rozenmad/Menori: Library for 3D rendering with LÖVE.](https://github.com/rozenmad/MenoriO)
