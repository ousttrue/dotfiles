- [GitHub - luvit/luv: Bare libuv bindings for lua](https://github.com/luvit/luv)

## nvim

- [Luvref - Neovim docs](https://neovim.io/doc/user/luvref.html)
- [🔁 Using LibUV in Neovim](https://teukka.tech/vimloop.html)

```lua
---@class uv
local uv = vim.uv
```

## filesystem

- [Luvref - Neovim docs](https://neovim.io/doc/user/luvref.html#luv-file-system-operations)
- [luv/docs/filesystem.rst at master · aantron/luv · GitHub](https://github.com/aantron/luv/blob/master/docs/filesystem.rst)

## iter dir

```lua
  local fs, err, msg = uv.fs_scandir(path)
  if err then
    print(err, msg)
    return
  end
  if fs then
    while true do
      local name, type, err, msg = uv.fs_scandir_next(fs)
      if not name then
        break
      end
      print(name, type)
    end
  end
```
