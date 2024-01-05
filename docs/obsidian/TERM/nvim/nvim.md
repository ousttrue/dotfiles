---
aliases: [neovim]
---

#red

- [News - Neovim](https://neovim.io/news/)
- [Roadmap - Neovim](https://neovim.io/roadmap/)
```sh
nvim +Tutor
```

# vscode

- [📜2023-10-07 vscode-neovimを導入してみた - Minerva](https://minerva.mamansoft.net/Notes/%F0%9F%93%9C2023-10-07+vscode-neovim%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F)

- [Vim基本 #Vim - Qiita](https://qiita.com/kishiro/items/1899519d243b59973406)

# articles
- [vim.ui.inputを自作floating windowにした (Vim駅伝)](https://ryota2357.com/blog/2023/neovim-custom-vim-ui-input/)
- @2022 [Neovim の設定集（2022年12月30時点） - 閑古鳥ブログ](https://kankodori-blog.com/posts/2022-12-30/)
- @2023 [Neovim で今風のプラグインを書く方法 - Speaker Deck](https://speakerdeck.com/delphinus/neovim-dejin-feng-nopuraguinwoshu-kufang-fa)
- @2023 [This Week In Neovim — 16 Jan 2023](https://this-week-in-neovim.org/2023/Jan/16)
- @2022 [【Neovim】memolist.vimを使ってメモをとり、telescope-memo.nvimで検索する](https://zenn.dev/koga1020/articles/009766e1bec42c)
- @2023 [Neovimの見た目を削ぎ落とした | 点と接線。](https://riq0h.jp/2023/01/30/134307/)
- @2022 [vim沼: NeovimのReact、TypeScript、Tailwind CSS用セットアップ](https://zenn.dev/takuya/articles/4472285edbc132)
- @2022 [Vimで古代ギリシア語【自作プラグインのすすめ】 - Qiita](https://qiita.com/NI57721/items/06fc78227faaea9bce90)
- @2022 [今年お世話になった 12 個の Vim (Neovim) プラグインを紹介します](https://zenn.dev/vim_jp/articles/2022-12-12-vim-plugin-thanks#1.-tani%2Fvim-jetpack)
- @2022 [NeovimをもっとLuaLuaさせた | 点と接線。](https://riq0h.jp/2022/10/21/150848/)
- [Learn Neovim The Practical Way. All articles on how to configure and… | by alpha2phi | Medium](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f#545a)
		- [Neovim for Beginners — init.lua. Let’s start our journey to customize… | by alpha2phi | Medium](https://alpha2phi.medium.com/neovim-for-beginners-init-lua-45ff91f741cb)

# Version
## v0.10.0
## v0.9.2
- @20230907
## v0.9.0
- @2023
## v0.8.0
- [Neovim 40個のおすすめオプション](https://jp.magicode.io/denx/articles/eb5a9c43526e4592937977bf3a959ad3)
- filetype.lua
- @2022 [Neovim 0.8がリリース - filetype.luaのデフォルト有効化など多数の変更 | ソフトアンテナ](https://softantenna.com/blog/neovim-0-8-released/)
### winbar
- [https://twitter.com/neovim/status/1527849682570977282](https://twitter.com/neovim/status/1527849682570977282)

## v0.7.0
- Tree-sitter integration (highlighting, folds)
- Better file-change detection
- TUI as a remote UI ($NVIM, --remote)
- Externalized UI: window layout events, ext_statusline
- Lua remote plugin host
- Embed Neovim everywhere

## v0.6.0
- Unified [[nvim_lsp]] API
- Updated defaults

## v0.5.0 @2021-07-21
- [Neovim News #11 - The Christmas Issue - Neovim](https://neovim.io/news/2021/07)
- Expanded Lua API and user config (init.lua)
- Built-in Language Server Protocol (LSP) support
- Tree-sitter integration (experimental)
- Decorations API improvements: extmarks, virtual text, highlights

## v0.5.1
- Lua API improvements
- LSP support improvements (v3.16 spec coverage, configuration)

# XDG

|xdg|unix|windows|
|-|-|-|
|XDG_CONFIG_HOME|~/.config/nvim|%LOCALAPPDATA%/nvim|
|XDG_DATA_HOIME|~/.local/share/nvim|%LOCALAPPDATA%/nvim-data|

# build
- [Building Neovim · neovim/neovim Wiki · GitHub](https://github.com/neovim/neovim/wiki/Building-Neovim#building-on-windows)
- @2021 [WindowsでのNeovim build方法 - Qiita](https://qiita.com/Elgonian/items/5e0b17c00372782c6d42)

## depndencies
- [neovim/CMakeLists.txt at master · neovim/neovim · GitHub](https://github.com/neovim/neovim/blob/master/cmake.deps/CMakeLists.txt)

```sh
$ cmake -S cmake.deps -B .deps -G Ninja
$ cmake --build .deps
$ cmake -S . -B build -G Ninja
$ cmake --build build
$ cmake --install --prefix $HOME/local
```

# Links
[[nvim_lua]]   [[nvim_snippet]]
## UI
[[nvim_terminal]] [[nvim_virtualtext]] [[nvim_floating]] [[nvim_keymap]]
## plugins
[[nvim_packer]] [[vim_plugins]]
[[nvim_pluginmanager]]
## lsp
- [Lsp - Neovim docs](https://neovim.io/doc/user/lsp.html)
[[nvim_lsp]] [[nvim_lsp]]  
## ex buffer
[[nvim_tree]]
## in buffer
[[treesitter]] [[nvim_statusline]]
## filetypes
[[cpp]] [[lua]]
[[json]] [[toml]]

# MSYS
[[nvim_msys2]]
