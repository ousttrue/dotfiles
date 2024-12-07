- [nvim-lua-guide-ja/README.ja.md at master · willelz/nvim-lua-guide-ja · GitHub](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

# memo

- vim.notify
- gcc: commentstring
- https://www.rasukarusan.com/entry/2021/08/22/202248
- nvim_set_decoration_provider https://zenn.dev/notomo/articles/neovim-zebra-highlight

# 自作

- `nvim` @2023 https://zenn.dev/comamoca/articles/lets-make-neovim-plugin
- `vim` @2018 [自作NeoVimプラグインの軌跡 - NoahOrblog](https://noahorberg.hatenablog.com/entry/2018/12/16/204957)
- https://github.com/s1n7ax/neovim-lua-plugin-boilerplate

# reload

- [Lua製Neovim plugin開発でhot-reloading的な体験を得る](https://zenn.dev/notomo/articles/neovim-lua-plugin-hot-reload)

```lua
package.loaded["myplugin.mymodule"] = nil
```

# env

```lua
if vim.fn.has('win32') == 1 then
  print('is windows')
end
```

# string

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
