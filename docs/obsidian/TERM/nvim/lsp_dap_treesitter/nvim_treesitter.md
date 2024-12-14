https://neovim.io/doc/user/treesitter.html

# nvim version

## 0.12

## 0.9

- inspect

## 0.6

- @2021 `markdown` `highlights.scm` [日常に彩りを加える nvim-treesitter の設定術](https://zenn.dev/monaqa/articles/2021-12-22-vim-nvim-treesitter-highlight)

## 0.5

- @2021 `textobject` [Neovim v0.5 リリース記念 v0.5 の新機能を紹介します【後編】 | MoT Lab (GO Inc. Engineering Blog)](https://lab.mo-t.com/blog/neovim-v05-introduction-new-features-part-2)
- @2021 [Vim のすゝめ改 - Tree-sitter について | 株式会社創夢 — SOUM/misc](https://www.soum.co.jp/misc/vim-advanced/6/)
- @2020 [nvim-treesitter を勧めたい](https://zenn.dev/duglaser/articles/c02d6a937a48df)

# config

- @2024 `TSConfigInfo` [私はTreeSitterに座れていなかった](https://zenn.dev/atoyr/articles/8802733f238e6d)

# textobject

- [【Neovim】vifでメソッド内を範囲選択する方法 #Vim - Qiita](https://qiita.com/ysmb-wtsg/items/2c9eaf444c60ca172588)

`select`, `swap`, `move`

- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

# scripting

- @2022 https://phelipetls.github.io/posts/template-string-converter-with-neovim-treesitter/
- @2022 [The power of tree-sitter](https://jhcha.app/blog/the-power-of-treesitter/)

```lua
local start_row, start_col, end_row, end_col = node:range()
```

## ts_utils

- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/doc/nvim-treesitter.txt

```lua
local ts_utils = require "nvim-treesitter.ts_utils"
local node = ts_utils.get_node_at_cursor()
```

# queries

https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries/zig

```text title="checkhalth"
Parser/Features         H L F I J
  - bash                ✓ ✓ ✓ . ✓
  - c                   ✓ ✓ ✓ ✓ ✓

Legend: H[ighlight], L[ocals], F[olds], I[ndents], In[j]ections
```

```vim
:TSHighlightCapturesUnderCursor
```

## aerial

`aerial.scm`

## query capture

`scm`

- @2021 [日常に彩りを加える nvim-treesitter の設定術](https://zenn.dev/monaqa/articles/2021-12-22-vim-nvim-treesitter-highlight)

## highlights

- @2023 [Markdown のコードブロックとかテキストの文脈に合わせて背景色を変える tsnode-marker.nvim を作った | Atusy's blog](https://blog.atusy.net/2023/04/19/tsnode-marker-nvim/)
- hlargs

```vim
:TSEditQuery
:TSEditQueryUserAfter highlights markdown
```

## textobject

- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

[[vim_textobject]]

## outline

## fold

- `nvim-ufo`
- `fold` @2022 [Code Folding in Neovim with Tree-sitter :: John Maguire](https://www.jmaguire.tech/posts/treesitter_folding/)

## formatter

## injection

`nvim/after/queries/lua/injections.scm`

- @2023 [プラグインを URL で指定しやすくするために、tree-sitter で URI パーサーを作って Neovim を彩ってみた | Atusy's blog](https://blog.atusy.net/2023/11/17/tree-sitter-uri/)
- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/markdown/injections.scm
- https://github.com/tree-sitter/tree-sitter-html/blob/master/queries/injections.scm## PlayGround

## indents

- [NeovimビルトインのインデントとLSPのDocumentFormatの挙動の違いに辟易としたら :: s1ck h4ck ](https://4nm1tsu.com/posts/a8ipkgi/#%E5%8F%82%E8%80%83%E6%96%87%E7%8C%AE)

# install 先

- prebuilt
- laza config
- 手動 TSinstall

## path

`AppData/Local/nvim-data/lazy/nvim-treesitter\\parser\\json.so`

## 命名規則

大文字小文字含めた一貫性。

- js: grammar.js name: LANG
- lua: parser_config: LANG
- c: src/scanner.c: LANG

# error!

https://github.com/LunarVim/LunarVim/issues/3680

```
Could not load parser for svelte: "...eovim/share/nvim/runtime/lua/vim/treesitter/language.lua:103: no parser for 'svelte' lan
guage, see :help treesitter-parsers"guage, see :help treesitter-parsers"

[nvim-treesitter] [0/1] Downloading tree-sitter-svelte...
[nvim-treesitter] [0/1] Checking out locked revision
[nvim-treesitter] [0/1] Compiling...
parser.c^M
scanner.c^M
AppData\Local\nvim-data\tree-sitter-svelte\src\allocator.h(1): warning C4819: The file contains a character tha
t cannot be represented in the current code page (932). Save the file in Unicode format to prevent data loss^M
AppData\Local\nvim-data\tree-sitter-svelte\src\allocator.h(78): error C2059: syntax error: ')'^M

Error executing lua: ...s/Neovim/share/nvim/runtime/lua/vim/treesitter/query.lua:248: Query error at 26:3. Invalid node type "
note":
((note) @text.note
```

- [nvim-treesitter で「query: invalid node type at...」エラーが出た #neovim - Qiita](https://qiita.com/ZOI_dayo/items/3c39252c729dd27393f3)

```
> rmrf C:\Users\oustt\AppData\Local\nvim-data
```
