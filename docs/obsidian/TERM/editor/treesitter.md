[Atom understands your code better than ever before - The GitHub Blog](https://github.blog/2018-10-31-atoms-new-parsing-system/)

- [Tree-sitter ｜ Introduction](https://tree-sitter.github.io/tree-sitter/)

  - [Tree-sitter ｜ Using Parsers](https://tree-sitter.github.io/tree-sitter/using-parsers)
  - [tree-sitter/api.h at master · tree-sitter/tree-sitter · GitHub](https://github.com/tree-sitter/tree-sitter/blob/master/lib/include/tree_sitter/api.h)

- [Neovim v0.5 リリース記念 v0.5 の新機能を紹介します【後編】 | MoT Lab (GO Inc. Engineering Blog)](https://lab.mo-t.com/blog/neovim-v05-introduction-new-features-part-2)
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
