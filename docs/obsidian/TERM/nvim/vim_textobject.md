`~vim-7.0`

# Builtin
- @2015 [Vimのテキストオブジェクトを本気出して纏めてみた - 人生シーケンスブレイク](https://shinespark.hatenablog.com/entry/2015/11/12/070000)
- [Vim のすゝめ - テキストオブジェクト | 株式会社創夢 — SOUM/misc](https://www.soum.co.jp/misc/vim-no-susume/8/)

Operator
- c hange
- d elete
- y ank
- v 

TextObject
- a: an, around
- i: inner

- word, `iw`, `aw`
- sentense, `is`, `as`
- paragraph, `ip`, `ap`

# sround.vim
- [vim の text-object をより便利に使えるプラグイン - surround.vim - A Day in the Life](https://secon.dev/entry/20061225/1167032528/)

## 囲っているテキストを操作

| |囲い|中身| |
|-|-|-|-|
|a|〇|〇|  |
|i|-|〇|  |
|s|〇|-|sround.vim|  
|cst<|

## 選択範囲を囲う
`S'`
`S"`

## 選択範囲にタグを追加
`St`
`ex. vatSt`

# sandwich.vim
- [GitHub - machakann/vim-sandwich: Set of operators and textobjects to search/select/edit sandwiched texts.](https://github.com/machakann/vim-sandwich)

# mini.ai

- [Neovimのテキストオブジェクトをカスタムできるmini.aiが便利 | Atusy's blog](https://blog.atusy.net/2023/01/27/mini-ai-nvim/)

# outline
- [Vimでアウトライン範囲を選択するtextobject](https://zenn.dev/kawarimidoll/articles/665dbd860c72cd)

# treesitter

[GitHub - nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

