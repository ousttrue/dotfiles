[[vim]] [[nvim]]

- [Quickfix - Neovim docs](https://neovim.io/doc/user/quickfix.html)
- [quickfix - Vim日本語ドキュメント](https://vim-jp.org/vimdoc-ja/quickfix.html)

# articles
- [vim-jp » Hack #237: 古い quickfix を参照する](https://vim-jp.org/vim-users-jp/2011/10/20/Hack-237.html)

- @2021 [VimのQuickFixでジャンプするときに直前のWindowを使う :: biosugar0](https://www.biosugar0.com/posts/2021/07/vim-qfenter/)
- @2020 [編集を加速するVimのquickfix機能 - daisuzu's notes](https://daisuzu.hatenablog.com/entry/2020/12/03/003629)
- @2013 [Vim のすゝめ - QuickFix | 株式会社創夢 — SOUM/misc](https://www.soum.co.jp/misc/vim-no-susume/7/)

- [QuickFix を自動で伸縮する（他、色々） - Qiita](https://qiita.com/delphinus/items/45117e5f8c0a3875e2f9)

# QuickFixCmdPose
- @2016 [VimのQuickFix-windowを自動で開く設定 – Kenchant](https://senooken.jp/post/2016/05/05/)

```vim
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep cwindow
```

# QuickFix
`global`
`clist` `cnext` `cprevious` `cfirst` `clast`
`cc`

# LocationList
`window local`
`clist` `lnext` `lprev` `lfirst` `llast`

# VimGrep
- [Vim初心者のQuickfixによる検索・置換入門](https://zenn.dev/tmrekk/articles/4380961a754287)
- @2013 [vimgrepとQuickfix知らないVimmerはちょっとこっち来い - Qiita](https://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b)

# errorformat(efm)

```
set errorformat=%f:%l%:c\ %t%*[^:]:\ %m,%Dninja: Entering directory\ `%f',%G-%.%#
```

# cexpr
- @2020 [Vimで:cexprを使ってgrep結果をquickfixに流す](https://skanehira.github.io/blog/posts/20200918-vim-cexpr-quickfix/)

# filter
