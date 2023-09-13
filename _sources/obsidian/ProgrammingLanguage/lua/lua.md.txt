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
[Lua 5.3 Reference Manual#Incompatibilities with the Previous Version](http://www.lua.org/manual/5.3/manual.html#8)

- bit operator
- [Lua(JIT)のbit演算](https://zenn.dev/uga_rosa/articles/5c6272ab8db9a1)

- integer
- [Lua 5.3 Bytecode Reference — Ravi Programming Language 0.1 documentation](https://the-ravi-programming-language.readthedocs.io/en/latest/lua_bytecode_reference.html)
	
## 5.2
[Lua 5.2 Reference Manual#8 – Incompatibilities with the Previous Version](http://www.lua.org/manual/5.2/manual.html#8)
 
- Since Lua 5.2 unpack function is now at table.unpack
https://www.lua.org/manual/5.2/readme.html#changes
- [files.catwell.info/misc/mirror/lua-5.2-bytecode-vm-dirk-laurie/lua52vm.html](http://files.catwell.info/misc/mirror/lua-5.2-bytecode-vm-dirk-laurie/lua52vm.html)
- [Lua 5.2.0をNiosIIに移植する：如是我聞～これからＦＰＧＡの話をしよう～：SSブログ](https://j-7system.blog.so-net.ne.jp/2012-05-08) 
- [Lua 5.1とLua5.2の違い - エンジニアのソフトウェア的愛情](https://blog.emattsan.org/entry/20120609/1339204385)

### deprecated: luaL_register
- => luaL_requiref
- luaL_newlib(はグローバル変数登録しない)
- @2012 [Lua 5.1とLua 5.2の非互換について - エンジニアのソフトウェア的愛情](https://blog.emattsan.org/entry/20120416/1334584047)

> newproxy was deprecated in Lua 5.1 and removed in Lua 5.2.

- [c - Embedding Lua 5.2 and defining libraries - Stack Overflow](https://stackoverflow.com/questions/13442907/embedding-lua-5-2-and-defining-libraries)
## 5.1
https://www.lua.org/manual/5.1/manual.html#7
- [The LuaJIT Project](https://luajit.org/)
- [LuaをNiosIIへ移植するメモ：如是我聞～これからＦＰＧＡの話をしよう～：SSブログ](https://j-7system.blog.ss-blog.jp/2012-05-06)

> newproxy was deprecated in Lua 5.1 and removed in Lua 5.2.

### luajit

### gopher lua
- @2015 [inforno :: LuaのGo言語実装を公開しました](http://inforno.net/articles/2015/02/15/gopher-lua-released)

# removed: newproxy
- [newproxy - 野良C++erの雑記帳](https://gintenlabo.hatenablog.com/entry/20100903/1283521878)

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

## tui
- [spilt / lua-debug-tui — Bitbucket](https://bitbucket.org/spilt/lua-debug-tui/src/master/)

# table
- [Luaのちょっと分かりにくいけど便利かもしれない機能 - yappyの日記](https://yappy-t.hatenadiary.org/entry/20100325/1269536711)
