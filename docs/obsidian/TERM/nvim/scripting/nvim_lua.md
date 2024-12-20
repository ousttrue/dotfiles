- [nvim-lua-guide-ja/README.ja.md at master · willelz/nvim-lua-guide-ja · GitHub](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

# command 登録

```lua
vim.api.nvim_create_user_command("COMMAND_NAME", function()
  -- callback
end, {})
```

# autocommand

# platform

```lua
if vim.fn.has('win32') == 1 then
  print('is windows')
end
```

# string

## split

## startswith

## endswith

## match

# table

## insert

## join

# buffer

## current buffer

# path

## path.join

## exists
