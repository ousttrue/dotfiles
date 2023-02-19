[[nvim]]

- @2013 [VimScriptざっくりチュートリアル(バッファ編集編) - かせいさんとこ](https://kasei-san.hatenadiary.org/entry/20130714/p1)

# buffer の種類
- [[Vim問題] バッファ一覧の記号の意味は？ | Vim入門](https://vim.blue/buffers-list/)
- @2019 [Vim で自前バッファを用意するプラグインを書く - あれ](https://tennashi.hatenablog.com/entry/2019/12/23/095237)

```vim
setlocal buftype=nofile
setlocal bufhidden=hide
setlocal noswapfile nobuflisted
```

# 関数
## bufnr
## bwipeout
