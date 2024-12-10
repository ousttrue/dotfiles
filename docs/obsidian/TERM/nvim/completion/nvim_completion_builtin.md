- [vim-jp » Hack #4: Insert mode補完　導入編](https://vim-jp.org/vim-users-jp/2009/05/01/Hack-4.html)
- [vim-jp » Hack #9: Insert mode補完　設定編](https://vim-jp.org/vim-users-jp/2009/05/11/Hack-9.html)
- [VimのCTRL-X補完について - daisuzu's notes](https://daisuzu.hatenablog.com/entry/2015/12/05/002129)

```
1. 行全体                                               i_CTRL-X_CTRL-L
2. 現在のファイルのキーワード                           i_CTRL-X_CTRL-N
3. 'dictionary' のキーワード                            i_CTRL-X_CTRL-K
4. 'thesaurus' のキーワード, thesaurus-style            i_CTRL-X_CTRL-T
5. 編集中と外部参照しているファイルのキーワード         i_CTRL-X_CTRL-I
6. タグ                                                 i_CTRL-X_CTRL-]
7. ファイル名                                           i_CTRL-X_CTRL-F
8. 定義もしくはマクロ                                   i_CTRL-X_CTRL-D
9. Vimのコマンドライン                                  i_CTRL-X_CTRL-V
10. ユーザー定義補完                                    i_CTRL-X_CTRL-U
11. オムニ補完                                          i_CTRL-X_CTRL-O
12. スペリング補完                                      i_CTRL-X_s
13. 'complete' のキーワード                             i_CTRL-N i_CTRL-P
```

# Built-in completion

- https://www.reddit.com/r/neovim/comments/1d7j0c1/a_small_gist_to_use_the_new_builtin_completion/
- `lsp.on_attach` [Built-in completion + snippet Neovim setup · GitHub](https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc)

```lua
vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
```

https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/completion.lua#L718

https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/completion.lua#L615
