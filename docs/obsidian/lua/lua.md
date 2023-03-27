#red

- [The Programming Language Lua](https://www.lua.org/)

- [GitHub - dibyendumajumdar/ravi: Ravi is a dialect of Lua, featuring limited optional static typing, JIT and AOT compilers](https://github.com/dibyendumajumdar/ravi)

[Lua: documentation](https://www.lua.org/docs.html)
- [LabLua - Programming Language Research](http://www.lua.inf.puc-rio.br/publications.html)

# articles
- [Tags - lilyum ensemble](https://nymphium.github.io/tags.html#Lua-ref)

# Versions
https://www.lua.org/versions.html

## 5.4
http://www.lua.org/work/doc/#changes

## `5.3
- integer
https://www.lua.org/manual/5.3/readme.html#changes
- [Lua 5.3 Bytecode Reference — Ravi Programming Language 0.1 documentation](https://the-ravi-programming-language.readthedocs.io/en/latest/lua_bytecode_reference.html)
	
## 5.2
https://www.lua.org/manual/5.2/readme.html#changes
- [files.catwell.info/misc/mirror/lua-5.2-bytecode-vm-dirk-laurie/lua52vm.html](http://files.catwell.info/misc/mirror/lua-5.2-bytecode-vm-dirk-laurie/lua52vm.html)
- [Lua 5.2.0をNiosIIに移植する：如是我聞～これからＦＰＧＡの話をしよう～：SSブログ](https://j-7system.blog.so-net.ne.jp/2012-05-08) 

### deprecated: luaL_register
- => luaL_requiref
- luaL_newlib(はグローバル変数登録しない)
- @2012 [Lua 5.1とLua 5.2の非互換について - エンジニアのソフトウェア的愛情](https://blog.emattsan.org/entry/20120416/1334584047)

## 5.1
https://www.lua.org/manual/5.1/manual.html#7
- [The LuaJIT Project](https://luajit.org/)
- [LuaをNiosIIへ移植するメモ：如是我聞～これからＦＰＧＡの話をしよう～：SSブログ](https://j-7system.blog.ss-blog.jp/2012-05-06)

# standalone
- [Lua 5.3 リファレンスマニュアル](http://milkpot.sakura.ne.jp/lua/lua53_manual_ja.html#7)

# debugger
## Lua Debug
高機能だがインタプリターを改造しているので、`standalone` の lua で動くプロジェクトじゃないと適用できない。
- [Lua Debug - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=actboy168.lua-debug)

## Local Lua Debugger
- [Local Lua Debugger - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

デバッガに付属しないインタプリターを使う場合、ソース側にデバッガーの開始が必要。
```lua
require("lldebugger").start()
```
