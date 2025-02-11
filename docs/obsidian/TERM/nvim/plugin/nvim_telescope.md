[[nvim]]

https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md

- [Neovim for Beginners — Fuzzy File Search (Part 2) | by alpha2phi | Medium](https://alpha2phi.medium.com/neovim-for-beginners-fuzzy-file-search-part-2-2aab95fe8cfe)

- [How to paste current word under the cursor to telescope](https://www.reddit.com/r/neovim/comments/ook0o6/how_to_paste_current_word_under_the_cursor_to/)

# mappings

- https://www.reddit.com/r/neovim/comments/116fuf9/how_to_vertically_center_cursor_in_buffer_window/

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

## livegrep

- [GitHub - nvim-telescope/telescope-live-grep-args.nvim: Live grep with args](https://github.com/nvim-telescope/telescope-live-grep-args.nvim)

# keymaps

[[nvim_keymap]]

- @2022 [telescope.nvimで作る簡易コマンドパレット（VSCodeのCtrl + Shift + Pっぽいの） | Atusy's blog](https://blog.atusy.net/2022/11/03/telescope-as-command-pallete/)

# custom

## source

- @2023 [telescope.nvim 拡張機能のつくりかた](https://zenn.dev/sankantsu/articles/af04828900d544)

## highlight

- [Telescope.nvimの実装を読みながら自分の設定をカスタマイズする | ushmz&#x27;s Blog](https://www.ushmz.dev/note/8bee4f65-40f6-47f3-b1da-7734b68c6008)
