[[fuzzyfinder]]
- [fzf（fuzzy finder）の便利な使い方をREADME, Wikiを読んで学ぶ - もた日記](https://wonderwall.hatenablog.com/entry/2017/10/06/063000)
- [fzfのpreview関連のオプション調べてみた](https://zenn.dev/eetann/articles/2022-08-27-fzf-preview)

- @2020 [fzfの使い方を学んでいく – yurublog](https://ss191215.stars.ne.jp/2020/03/28/182/)ko
- @2019 [[ターミナル]fzfを使った自作インタラクティブアプリを作ってみよう！〜git addを快適に〜 | DevelopersIO](https://dev.classmethod.jp/articles/fzf-original-app-for-git-add/)
- @2018 [第504回　インタラクティブフィルター「fzf」の活用 | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0504)
- @2017 [fzf（fuzzy finder）の便利な使い方をREADME, Wikiを読んで学ぶ - もた日記](https://wonderwall.hatenablog.com/entry/2017/10/06/063000#%E3%83%97%E3%83%AC%E3%83%93%E3%83%A5%E3%83%BC%E3%82%A6%E3%82%A3%E3%83%B3%E3%83%89%E3%82%A6)

# Layout
## prompt top
```
--layout=reverse
```

# preview
- [fzfのpreview関連のオプション調べてみた](https://zenn.dev/eetann/articles/2022-08-27-fzf-preview)

## command
```
--perview="bat {}"
```

## window
下
```
--preview-window=down
--preview-window down:70%
```

## git switch
- @2022 [fzf で git log を見ながらブランチ移動する](https://zenn.dev/yamo/articles/5c90852c9c64ab)

# python
- [GitHub - nk412/pyfzf: A python wrapper for fzf](https://github.com/nk412/pyfzf)

# key
## ctrl-t
```sh
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'
```

## ctrl-r
history

## alt-c
chdir

## **tab
- [fzf-tab-completion のメモ · GitHub](https://gist.github.com/buzztaiki/899b16dee98dab7f700541df751c45ca)
