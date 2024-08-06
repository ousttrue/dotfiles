[FAQ · tmux/tmux Wiki · GitHub](https://github.com/tmux/tmux/wiki/FAQ

# Version

## 4

## 3.3a

## 3.2

```
# utf8proc
make PREFIX=/usr/local
# tmux-3.2
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
./configure --prefix=/usr/local --enable-utf8proc
```

- [c - AC_SEARCH_LIBS on a static library that itself has dependencies? - Stack Overflow](https://stackoverflow.com/questions/21647840/ac-search-libs-on-a-static-library-that-itself-has-dependencies)
- [tmux の コピペ と クリップボード - Qiita](https://qiita.com/mnishiguchi/items/b8526fecd69aa87d2f7e)

## 2.9

- [tmux 。スタイルの確認方法を調べて、アクティブなウインドウを目立たせたい – oki2a24](https://oki2a24.com/2019/05/21/how-to-check-tmux-style-and-highlight-active-window/)
  > _2.8 から 2.9 へとなった時に、mode-fg, mode-bg, mode-attr のオプションは使えなくなったようです。代わりに、 mode-style に一本化さてたとのこと_

```
set -g mode-style fg=yellow,bg=red,blink,underline
```

## 2.6

- [GitHub - z80oolong/tmux-eaw-fix: tmux 2.6 以降において East Asian Ambiguous Character を全角文字の幅で表示する](https://github.com/z80oolong/tmux-eaw-fix)

## 2.3

- [koie blog : tmux2.3: pane-border-status](https://hkoie.livedoor.blog/archives/55582834.html)

## 2.0

# articles

- @2023 [tmuxの知られざるパワフルな機能を紹介してみる - VISASQ Dev Blog](https://tech.visasq.com/introduce-tmux-powerful-features)
- @2023 [便利なtmuxの使い方をまとめてみる](https://zenn.dev/azunasu/articles/25d9999ca0fb96)

# layout

## session

## window(tab)

- title

## pane

- https://superuser.com/questions/962986/in-tmux-is-it-possible-to-list-all-panes-in-all-windows

## popup

一時的に `floating window` を表示

- https://github.com/denisidoro/navi

### statusline

- [tmuxのペインのステータスラインにgitのブランチとかディレクトリとか表示する(プロンプトはもう古い) - Qiita](https://qiita.com/arks22/items/db8eb6a14223ce29219a)

# .tmux.conf

```.tmux.conf
unbind C-b
set -g prefix C-l
bind C-l send-prefix
```

- [.tmux.conf · GitHub](https://gist.github.com/disktnk/2075bc74fbc5f079657d742b808e2993)

## set

- [UNIX/tmux/set-optionの-gと-sと-wとset-window-option - yanor.net/wiki](https://yanor.net/wiki/?UNIX/tmux/set-option%E3%81%AE-g%E3%81%A8-s%E3%81%A8-w%E3%81%A8set-window-option)

|        | session                         | global  | sever   |
| ------ | ------------------------------- | ------- | ------- |
|        | set-option, set                 | set -g  | set -s  |
| window | set-window-option, set -w, setw | setw -g | setw -s |

## show

```
tmux show-options -g `|` grep status
```

# satusline

## powerline

- [【tmux】Powerlineでステータスバーをカスタマイズ | amateur engineer's blog](https://amateur-engineer-blog.com/tmux-powerline/)

## window list

## left / right

## pane-border-status
