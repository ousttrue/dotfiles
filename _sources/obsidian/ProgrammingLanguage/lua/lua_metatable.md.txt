
# metatable の単位。instance or class
strings, numbers, nil, functions and lightuserdata have a single metatable for the whole type. tables and full userdata have a metatable for each instance.

from the docs:

> Tables and full userdata have individual metatables (although multiple tables and userdata can share their metatables). Values of all other types share one single metatable per type; that is, there is one single metatable for all numbers, one for all strings, etc.strings, etc.

# 型情報(cats)を踏まえた構成
[[lua_language_server]]
```lua
---@class SomeInstance
---@field nmae string

---@class Some: SomeInstance
local Some = {}
Some.__index = Some

---factory
---@param name string
---@return Some
function Some.new(name)
  ---@type SomeInstance
  local instance = {
    name = name,
  }
  return setmetatable(instance, Some)
end

function Some:hello()
  print(self.name)
end

---メソッド。演算子オーバーロード
function Some:__add(rhs)
end

return Some
```

## `__index` と `:`
通常のメソッドと、演算子オーバーロード類を同じ table に定義できる。

static 関数のメソッド呼び出しと メンバー関数呼び出し両方に、`:` が適用可能であるが `:` をメンバー関数呼び出し専用にする。

## `__call` をコンストラクターに使わない

コールには２つの意味がある、
`self` が型を表すときは、コンストラクター。
`self` がインスタンスを表すときは、関数オブジェクトの呼び出し。
前者を捨てて `new` 関数を使う規約にする。
次項も参照のこと。

## 継承は要らないのでは？
ポリモーフィズムを使う局面ある？
