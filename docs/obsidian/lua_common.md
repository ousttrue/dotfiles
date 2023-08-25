[[lua]]

- [[nvim]] `luajit => 5.1`
- [[wezterm]]`?`
- [[nyagos]] `gopher lua => 5.1` で共用するようなライブラリ

```lua
-- `LUA_PATH=$HOME/lua/?.lua;$HOME/lua/?/init.lua`
local S = require 'shared'
```
みたいな感じで

# table
# string
`split`, `join`, `starts_with`

# path
- [GitHub - moteus/lua-path: File system path manipulation library](https://github.com/moteus/lua-path)

# escape sequence
## color
## powerline
