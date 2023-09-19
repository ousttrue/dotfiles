
[Lua 5.1 Reference Manual#2.4.5 – For Statement](https://www.lua.org/manual/5.1/manual.html#2.4.5)

# generic
- [Programming in Lua : 7.1](https://www.lua.org/pil/7.1.html)
- [ジェネリックfor文を使って独自のイテレータを作る - Qiita](https://qiita.com/hevo2/items/604b5405a981fd5fd207)

```lua
for namelist in explist do 
	block
end
```

# numeric

```lua
for Name `=´ exp `,´ exp [`,´ exp] do 
	block 
end

 do
   local _f_, _s_, _var_ = _explist_
   while true do
	 local _var_1_, ···, _var_n_ = _f_(_s_, _var_)
	 _var_ = _var_1_
	 if _var_ == nil then break end
	 _block_
   end
 end
```
