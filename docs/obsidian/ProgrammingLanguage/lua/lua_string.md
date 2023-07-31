[[lua]]

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

# string.gmatch
```lua
t = {}
s = "from=world, to=Lua"
for k, v in string.gmatch(s, "(%w+)=(%w+)") do
	t[k] = v
end
```
