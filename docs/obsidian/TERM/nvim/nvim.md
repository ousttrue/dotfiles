# TODO

- plugin unicode を文字表示
- spelling English
- cmp で pinyin
- cmp で 四角号碼入力
- markdown gx: link の title の方から gx したい
- VSCODE みたいに入力が複数あるやつ

# vim

- [NeoVim使いのためのnvim-lspconfig おすすめキーマッピングの紹介 - アルパカログ](https://alpacat.com/blog/nvim-lspconfig-key-mappings)
- https://github.com/gelguy/wilder.nvim
- https://easyramble.com/vim-leader-space-vimrc.html
- [Vimでの日本語編集がはかどるキーマッピング - Qiita](https://qiita.com/ssh0/items/9e7f0d8b8f033183dd0b)
- [【Windows】コンテキストメニュー(右クリック)に [Vimで開く] を追加する手順 – oki2a24](https://oki2a24.com/2017/05/27/add-edit-with-vim-to-right-click-context-menu/)
- [GitHub - tjdevries/colorbuddy.nvim: Your color buddy for making cool neovim color schemes](https://github.com/tjdevries/colorbuddy.nvim)

vim 文字コード
`ga` でカーソル上の文字のコードが分かる

# replace

- [Vimでs/正規表現/関数/ substituteで置換後文字列を関数にする方法 | コマンドの達人](https://life-is-command.com/vim-sub-replace-expression/)

# 日本語

- [Vimでの日本語編集がはかどるキーマッピング - Qiita](https://qiita.com/ssh0/items/9e7f0d8b8f033183dd0b)o

```
grep search
- pattern
- include
- exclude

file search
- pattern
- include
- exclude
```

# version

- [News - Neovim](https://neovim.io/news/)
- [Roadmap - Neovim](https://neovim.io/roadmap/)

## 0.12 dev

- tbl_xxx の deprecated

## 0.11 dev

## 0.10

`202405`

- https://gihyo.jp/article/2024/05/neovim-0.10
- https://neovim.io/doc/user/news-0.10.html
  - https://neovim.io/doc/user/options.html#'winfixbuf'
  - https://neovim.io/doc/user/treesitter.html#treesitter-highlight-groups
  - https://neovim.io/doc/user/deprecated.html#vim.diagnostic.goto_next()
  - `gx` https://neovim.io/doc/user/lua.html#vim.ui.open()

## 0.9

- https://neovim.io/doc/user/news-0.9.html#news-0.9

# 一から設定しなおす手順

- init.lua(basic)
- lazy
- lua 開発環境(treesitter, lsp, stylua)
- telescope
- cmp

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
