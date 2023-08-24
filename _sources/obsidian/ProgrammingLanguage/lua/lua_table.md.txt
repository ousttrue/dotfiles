[[lua]]
# array
- [Luaの長さ演算子 - n-diary](https://noriok.hatenablog.com/entry/2012/03/27/002111)
```lua
```

# map
```lua
assert(#map == 0, 'always')
```

# iterate table
[Iterating through a Lua table from C++? - Stack Overflow](https://stackoverflow.com/questions/1438842/iterating-through-a-lua-table-from-c)

# generic for

## iterator関数

```lua
-- A for statement like

     for var_1, ···, var_n in explist do block end

-- is equivalent to the code:

     do
       local f, s, var = explist
       while true do
         local var_1, ···, var_n = f(s, var)
         var = var_1
         if var == nil then break end
         block
       end
     end
```

## next
次の index(key) を返す
> next returns the next index of the table and its associated value
