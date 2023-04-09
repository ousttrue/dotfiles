[[nvim|nvim]]

[nvim-lua-guide-ja/README.ja.md at master · willelz/nvim-lua-guide-ja · GitHub](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

# 高速化

@2022 [Neovimの設定を見直して起動を30倍速にした](https://zenn.dev/kawarimidoll/articles/8172a4c29a6653)

```
> nvim --startuptime ./startup.log
```

# Directory

[neovim/stdpaths.c at master · neovim/neovim · GitHub](https://github.com/neovim/neovim/blob/master/src/nvim/os/stdpaths.c#L24)

[[xdg]]
- `XDG_CONFIG_HOME`
- `XDG_DATA_HOME`
- `XDG_STATE_HOME`
- `XDG_CACHE_HOME`

# Clear
- $LOCALAPPDATA/nvim-data
- ~/.local/share/nvim-data
- ~/.cache/nvim
- ~/.config/nvim/plugin/packer_compiled.lua
