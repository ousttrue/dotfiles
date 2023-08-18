[[NerdFont]]

# Version
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

## 2.6
- [GitHub - z80oolong/tmux-eaw-fix: tmux 2.6 以降において East Asian Ambiguous Character を全角文字の幅で表示する](https://github.com/z80oolong/tmux-eaw-fix)

## 2.3
- [tmuxのペインのステータスラインにgitのブランチとかディレクトリとか表示する(プロンプトはもう古い) - Qiita](https://qiita.com/arks22/items/db8eb6a14223ce29219a)

## 2.0

# .tmux.conf

```.tmux.conf
unbind C-b
set -g prefix C-l
bind C-l send-prefix
```

## set
- [UNIX/tmux/set-optionの-gと-sと-wとset-window-option - yanor.net/wiki](https://yanor.net/wiki/?UNIX/tmux/set-option%E3%81%AE-g%E3%81%A8-s%E3%81%A8-w%E3%81%A8set-window-option)

# vim
- [Tmux and Vim — configurations to be better together | Bugsnag Blog](https://www.bugsnag.com/blog/tmux-and-vim)

# satusline
## powerline
- [【tmux】Powerlineでステータスバーをカスタマイズ | amateur engineer's blog](https://amateur-engineer-blog.com/tmux-powerline/)

## shell
- [bashの .bash_profile と .bashrc の挙動の整理と使い分け方 - Qiita](https://qiita.com/ono_matope/items/feebac51afb346d9db0e)


# msys2 build
## patch
[Index of /msys/sources/](https://repo.msys2.org/msys/sources/)
## tmux
- [.tmux.conf · GitHub](https://gist.github.com/disktnk/2075bc74fbc5f079657d742b808e2993)
