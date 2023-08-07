[[nvim]]
[[lsp]]
[[treesitter]]
[[ColorScheme]]

- @2022 [Neovimのカラースキームを編集中のバッファのファイルパスに応じて変える | Atusy's blog](https://blog.atusy.net/2022/04/28/vim-colorscheme-by-buffer/)

# TreeSitter
- @2022 [自作のVim colorschemeをTreesitterに対応させる](https://zenn.dev/hachy/scraps/88d761f329a9c8)
- @2022  [treesitter colorscheme](https://zenn.dev/botamotch/scraps/a9a64e9924564e)
- @2020 [君はまだVimの真の美しさを知らない - Qiita](https://qiita.com/psyashes/items/1e1716a59a0dc22ea204)

# create
- @2023 [Vimカラースキーム自作のすすめ | Eureka Engineering](https://medium.com/eureka-engineering/recommend-generating-own-colorsheme-3114abe3e1d)
- @2022 [お手軽カラースキーム制作 - Qiita](https://qiita.com/slin/items/be6dddbdb49a790692ba)
- @2019 [vimのカラースキームの設定・編集方法（初心者〜上級者） - Qiita](https://qiita.com/sff1019/items/3f73856b78d7fa2731c7)

```lua
-- 定義開始
vim.o.background = "dark"
vim.g.colors_name = "THEME_NAME"
vim.cmd("hi clear")

-- 適用
vim.cmd[[colorscheme THEME_NAME]]
```

## ファイル配置に制約あり？

## service
### vim
- [ThemeCreator](http://mswift42.github.io/themecreator/#)

## colortemplate
[GitHub - lifepillar/vim-colortemplate: The Toolkit for Vim Color Scheme Designers!](https://github.com/lifepillar/vim-colortemplate)

## lush
- [GitHub - rktjmp/lush.nvim: Create Neovim themes with real-time feedback, export anywhere.](https://github.com/rktjmp/lush.nvim)

## base16
- [Base16 Gallery](https://tinted-theming.github.io/base16-gallery/)
- @2022 [俺自身がNeovim base16 colorschemeになることだ](https://zenn.dev/kawarimidoll/articles/8e58296f5b8118)

## 構成
UI部品とシンタックスハイライトの２部構成となる
### UI部品
### SyntaxHighlight
