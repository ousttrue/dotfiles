[[nvim]] [[lsp]] [[ColorScheme]]

- @2022 [Neovimのカラースキームを編集中のバッファのファイルパスに応じて変える | Atusy's blog](https://blog.atusy.net/2022/04/28/vim-colorscheme-by-buffer/)

# Site
- [Trending vim color schemes | vimcolorschemes](https://vimcolorschemes.com/)

# 適用タイミング
- [.vimrcでのcolorschemeでハマった - 水底](https://amaya382.hatenablog.jp/entry/2017/02/07/194320) 
```vim
colorscheme default
highlight CursorColumn ctermbg=black
set t_Co=256 " reset
```

## autocmd ColorScheme

```vim
autocmd colorscheme * highlight ErrorMsg ctermfg=213 ctermbg=16
```
# TreeSitter
[[treesitter]]
- [2022年の nvim-treesitter の変更・新機能を振り返る](https://zenn.dev/vim_jp/articles/2022-12-25-vim-nvim-treesitter-2022-changes)
- @2022 [自作のVim colorschemeをTreesitterに対応させる](https://zenn.dev/hachy/scraps/88d761f329a9c8)
- @2022  [treesitter colorscheme](https://zenn.dev/botamotch/scraps/a9a64e9924564e)
- @2020 [君はまだVimの真の美しさを知らない - Qiita](https://qiita.com/psyashes/items/1e1716a59a0dc22ea204)

## hlargs
- [GitHub - m-demare/hlargs.nvim: Highlight arguments' definitions and usages, using Treesitter](https://github.com/m-demare/hlargs.nvim)

# lsp
- [lsp-vimでエラーハイライトの見た目を変える方法 - ヘンゼルのパンくず](https://tmls.hatenablog.com/entry/2021/02/21/050729)
- [Neovim LSPでカーソル下の変数をハイライトする機能](https://zenn.dev/botamotch/scraps/62eda54e7fba90)

# ExtMark
- [【Neovim】好きな位置にテキストを埋め込んだりハイライトできる「ExtMark」の使い方 - ハイパーマッスルエンジニア](https://www.rasukarusan.com/entry/2021/08/22/202248)

# create
- @2023 [Vimカラースキーム自作のすすめ | Eureka Engineering](https://medium.com/eureka-engineering/recommend-generating-own-colorsheme-3114abe3e1d)
- @2022 [お手軽カラースキーム制作 - Qiita](https://qiita.com/slin/items/be6dddbdb49a790692ba)
- @2019 [vimのカラースキームの設定・編集方法（初心者〜上級者） - Qiita](https://qiita.com/sff1019/items/3f73856b78d7fa2731c7)
- @2016 [フルスクラッチからさいきょうの Vim カラースキームをつくろう！ - はやくプログラムになりたい](https://rhysd.hatenablog.com/entry/2016/12/17/191158)
- @2016 [自作Vimカラースキーム「Iceberg」の配色戦略 - ここぽんのーと](https://cocopon.me/blog/2016/02/iceberg/)
- @2013 [カラースキームを作ってみよう - 永遠に未完成](https://thinca.hatenablog.com/entry/20130410/1365530054)
- @2013 [Vimのカラースキーム/シンタックスファイルは自作しよう - プログラムモグモグ](https://itchyny.hatenablog.com/entry/20130315/1363317786)

```lua
-- 定義開始
vim.o.background = "dark"
vim.g.colors_name = "THEME_NAME"
vim.cmd("hi clear")

-- 適用
vim.cmd[[colorscheme THEME_NAME]]

-- 定義
vim.api.nvim_set_hl(0, "@repeat.lua", { fg = color.keyword })

vim.cmd[[hi link pythonOperator Statement]]
vim.api.nvim_set_hl(0, "your-group", { link = "another-group" })
```

## ファイル配置に制約あり？

## service
### vim
- [ThemeCreator](http://mswift42.github.io/themecreator/#)

## 調べる
`nvim-0.9.0`
- [syntax highlighting - How to get the highlight group of the word under the cursor in Neovim with Treesitter installed? - Vi and Vim Stack Exchange](https://vi.stackexchange.com/questions/39781/how-to-get-the-highlight-group-of-the-word-under-the-cursor-in-neovim-with-trees)
`Inspect`

- @2013 [Vimでハイライト表示を調べる](https://rcmdnk.com/blog/2013/12/01/computer-vim/)
- [Vim – シンタックスハイライトの設定方法【文字の色の変更も】 | Howpon[ハウポン]](https://howpon.com/21776#i-5)
- [Vimでカーソル下のハイライト・グループ名を知る](https://hail2u.net/blog/software/vim-show-highlight-group-name-under-cursor.html)
```vim
:echo synIDattr(synID(line("."), col("."), 1), "name")
```

## 確認
### hitest
下記コマンドで、現在有効な全てのハイライトグループを確認できる。

```vim
:source $VIMRUNTIME/syntax/hitest.vim
```

### verbose
["TODO:" を目立たせたいと思った、どのファイルでも - ばかもりだし](https://baqamore.hatenablog.com/entry/2016/11/15/220358)

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
