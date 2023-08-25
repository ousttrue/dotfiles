[[lua]]

# string.sub
文字列の index アクセスは無い？

# string.find
```lua
string.find (s, pattern [, init [, plain]])
```
- return nil if not found
- return index

# string.match(s, pattern[, init])
- return nil if not found
- return captured
- return all if no capture
```lua
m, n, o = string.match('123', '(1)2(3)')
print(m, n, o)
1       3       nil
```

# string.gmatch
```lua
t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%w+)=(%w+)") do
	t[k] = v
end
```

# string metatable
`5.1` でできた。

```lua
> print(getmetatable("a"))
table: 0xa000069f0

("a"):lower() -- のようなことができる
```
