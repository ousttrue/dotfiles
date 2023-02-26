[[nvim]]

- [Neovim for Beginners — Fuzzy File Search (Part 2) | by alpha2phi | Medium](https://alpha2phi.medium.com/neovim-for-beginners-fuzzy-file-search-part-2-2aab95fe8cfe)

# builtin
```lua
local builtin = require "telescope.builtin"
```
## find_files
- @2022 [telescope.nvimプラグインによるファイル検索・テキスト検索ライフ | DevelopersIO](https://dev.classmethod.jp/articles/nvim_telescope/)
```vim
noremap <C-p> <cmd>Telescope find_files<cr>
```

## git_files

```lua
file_ignore_patterns = { "node_modules" }
```

# livegrep
- [GitHub - nvim-telescope/telescope-live-grep-args.nvim: Live grep with args](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)

# keymaps
[[nvim_keymap]]
- @2022 [telescope.nvimで作る簡易コマンドパレット（VSCodeのCtrl + Shift + Pっぽいの） | Atusy's blog](https://blog.atusy.net/2022/11/03/telescope-as-command-pallete/)

# layout
