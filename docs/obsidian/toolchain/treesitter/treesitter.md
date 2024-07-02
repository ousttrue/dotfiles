[Tree-sitter ｜ Introduction](https://tree-sitter.github.io/tree-sitter/)

[[nvim-treesitter]]

# creating `grammar.js`

- [Tree-sitter｜Creating Parsers](https://tree-sitter.github.io/tree-sitter/creating-parsers)
- [Guide to writing your first Tree-sitter grammar · GitHub](https://gist.github.com/Aerijo/df27228d70c633e088b0591b8857eeef)
- @2023 [プラグインを URL で指定しやすくするために、tree-sitter で URI パーサーを作って Neovim を彩ってみた | Atusy's blog](https://blog.atusy.net/2023/11/17/tree-sitter-uri/)
- @2022 https://zenn.dev/tanzaku/articles/tree-sitter-calculator

## sql

- @2022 [tree-sitter文法入門 | フューチャー技術ブログ](https://future-architect.github.io/articles/20221215a/)

## powershell

- https://github.com/airbus-cert/tree-sitter-powershell

## scala

- @2022 [Tree-sitter を用いた Scala 3 の高速パース &middot; eed3si9n](https://eed3si9n.com/ja/fast-scala3-parsing-with-tree-sitter/)

## rbs

- @2023 [rbsのtree-sitterパーサを書いて、neovimのシンタックスハイライトに利用する - joker1007’s diary](https://joker1007.hatenablog.com/entry/2023/11/17/162702)

# using

- [Tree-sitter ｜ Using Parsers](https://tree-sitter.github.io/tree-sitter/using-parsers)

# articles

- @2018 [Atom understands your code better than ever before - The GitHub Blog](https://github.blog/2018-10-31-atoms-new-parsing-system/)
- @2023 [Tree-sitter でシンタックスハイライトしたコードを HTML で出力するワンライナー - Lambda カクテル](https://blog.3qe.us/entry/2023/05/15/200750)

- [GitHub - nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

- @2023 [Tree-sitter でシンタックスハイライトしたコードを HTML で出力するワンライナー - Lambda カクテル](https://blog.3qe.us/entry/2023/05/15/200750)

# version

## runtime ABI version 14

nvim checkhealth

- TREE_SITTER_LANGUAGE_VERSION 14
- TREE_SITTER_MIN_COMPATIBLE_LANGUAGE_VERSION 13

# add parser

https://tree-sitter.github.io/tree-sitter/creating-parsers

- @2022 [Tree-sitter を用いた Scala 3 の高速パース · eed3si9n](https://eed3si9n.com/ja/fast-scala3-parsing-with-tree-sitter/)
- @2022 [tree-sitter 文法入門 | フューチャー技術ブログ](https://future-architect.github.io/articles/20221215a/)

## grammar.js

[Guide to writing your first Tree-sitter grammar · GitHub](https://gist.github.com/Aerijo/df27228d70c633e088b0591b8857eeef)

- @2023 [rbs の tree-sitter パーサを書いて、neovim のシンタックスハイライトに利用する - joker1007’s diary](https://joker1007.hatenablog.com/entry/2023/11/17/162702)

# neovim

`nvim-treesitter`

- @2021 [日常に彩りを加える nvim-treesitter の設定術](https://zenn.dev/monaqa/articles/2021-12-22-vim-nvim-treesitter-highlight)
- @2021 [Vim のすゝめ改 - Tree-sitter について | 株式会社創夢 — SOUM/misc](https://www.soum.co.jp/misc/vim-advanced/6/)
- @2020 [nvim-treesitter を勧めたい](https://zenn.dev/duglaser/articles/c02d6a937a48df)

# python

- [GitHub - tree-sitter/py-tree-sitter: Python bindings to the Tree-sitter parsing library](https://github.com/tree-sitter/py-tree-sitter)

# app

## cli

`cargo install tree-sitter-cli`

# emacs

- [How to Get Started with Tree-Sitter - Mastering Emacs](https://www.masteringemacs.org/article/how-to-get-started-tree-sitter)
- [EmacsConf - 2022 - talks - Tree-sitter beyond syntax highlighting](https://emacsconf.org/2022/talks/treesitter/)

# error

## heredoc_end

fix: remove ~/local/lib/nvim/parser

https://github.com/nvim-treesitter/nvim-treesitter/issues/3092
https://github.com/nvim-treesitter/nvim-treesitter/issues/5680

- @2022 [nvim-treesitter で「query: invalid node type at...」エラーが出た #neovim - Qiita](https://qiita.com/ZOI_dayo/items/3c39252c729dd27393f3)

```error
Query error at 9:4. Invalid node type "heredoc_end":
```
