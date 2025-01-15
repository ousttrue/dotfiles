コマンドライン引数。
`love.dll` が最初から分かれているので、起動スクリプトがあればデバッグできそう？

- `src/modules/love/love.jitsetup.lua`
- `src/modules/love/boot.lua`

改造しないと厳しそう？

- [Love as Lua module - LÖVE](https://love2d.org/forums/viewtopic.php?t=86145)

slandalone lua の `-e` オプションを追加するのが良いか？

`lua local-debug` でデバッグするのがよい。

- [GitHub - tomblind/local-lua-debugger-vscode: Local Lua Debugger for VSCode](https://github.com/tomblind/local-lua-debugger-vscode)

```lua
require("lldebugger").start()
```
