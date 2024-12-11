# Lua Debug

高機能だがインタプリターを改造しているので、`standalone` の lua で動くプロジェクトじゃないと適用できない。

- [Lua Debug - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=actboy168.lua-debug)

# Local Lua Debugger

- [Local Lua Debugger - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

デバッガに付属しないインタプリターを使う場合、ソース側にデバッガーの開始が必要。

```lua
require("lldebugger").start()
```

# tui

- [spilt / lua-debug-tui — Bitbucket](https://bitbucket.org/spilt/lua-debug-tui/src/master/)
