[[vim]] [[nvim]]

- [Quickfix - Neovim docs](https://neovim.io/doc/user/quickfix.html)
- [quickfix - Vim日本語ドキュメント](https://vim-jp.org/vimdoc-ja/quickfix.html)

# articles
- [vim-jp » Hack #237: 古い quickfix を参照する](https://vim-jp.org/vim-users-jp/2011/10/20/Hack-237.html)

- @2021 [VimのQuickFixでジャンプするときに直前のWindowを使う :: biosugar0](https://www.biosugar0.com/posts/2021/07/vim-qfenter/)
- @2020 [編集を加速するVimのquickfix機能 - daisuzu's notes](https://daisuzu.hatenablog.com/entry/2020/12/03/003629)
- @2013 [Vim のすゝめ - QuickFix | 株式会社創夢 — SOUM/misc](https://www.soum.co.jp/misc/vim-no-susume/7/)

# compiler

- https://github.com/Konfekt/vim-compilers

# QuickFix
## errorformat
- [quickfix - Vim日本語ドキュメント](https://vim-jp.org/vimdoc-ja/quickfix.html#errorformat)
```
set errorformat=%f:%l%:c\ %t%*[^:]:\ %m,%Dninja: Entering directory\ `%f',%G-%.%#
```

- @2012 [複数行のerrorformatをちょっと勉強した - ぼっち勉強会](https://kannokanno.hatenablog.com/entry/20120804/1344085048)

## cwindow, copen, cn, cp, cc
## QuickFixCmdPose
- @2016 [VimのQuickFix-windowを自動で開く設定 – Kenchant](https://senooken.jp/post/2016/05/05/)

```vim
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep cwindow
```
## makeprg
`from command stdout`
## cexpr
`from string or list`
- @2020 [Vimで:cexprを使ってgrep結果をquickfixに流す](https://skanehira.github.io/blog/posts/20200918-vim-cexpr-quickfix/)

## script
- setqflist
- getqflist

# LocationList
`window local`
`clist` `lnext` `lprev` `lfirst` `llast`

## script
- setloclist
- getloclist

# VimGrep
- [Vim初心者のQuickfixによる検索・置換入門](https://zenn.dev/tmrekk/articles/4380961a754287)
- @2013 [vimgrepとQuickfix知らないVimmerはちょっとこっち来い - Qiita](https://qiita.com/yuku_t/items/0c1aff03949cb1b8fe6b)

# scripting
## async
[[nvim_job]]
- @2020 [Asynchronous :make in Neovim with Lua - Phelipe Teles | Phelipe Teles](https://phelipetls.github.io/posts/async-make-in-nvim-with-lua/)
- [Updating a quickfix/location list asynchronously without interfering with another plugin · GitHub](https://gist.github.com/yegappan/3b50ec9ea86ad4511d3a213ee39f1ee0)
