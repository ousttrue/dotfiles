[[lua]]

```lua
-- `LUA_PATH=$HOME/local/lua/?.lua;$HOME/local/lua/?/init.lua`
local LCO = require 'common'
```
みたいな感じで

# lua version
- [[wezterm]] `lua-5.4`
- [[nyagos]] `gopher lua => 5.1`
- [[nvim]] `luajit => 5.1`

# system 判定
```lua
get_system()

'windows', 'linux', 'mac'
'msys', 'mingw', 'wsl'
```

# dotfiles 管理
## symbolic link
- -> dotfiles
- ~/.config 下で dotfiles 管理でないものを列挙

## download
- font
- skk dict
- rustup
- zig

##  packages
- pip
- cargo
- go

## build
- nvim

# table
# string
`split`, `join`, `starts_with`

# path
- [GitHub - moteus/lua-path: File system path manipulation library](https://github.com/moteus/lua-path)

# escape sequence
## color
## powerline
