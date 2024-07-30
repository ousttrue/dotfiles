[[OS/X11/X11]]

- @2022 [Arch Linux インストール (7) - 各設定](https://aznote.jakou.com/archlinux/install7.html)
- @2017 [Fontconfigでデフォルトのフォントを設定する方法 | 普段使いのArch Linux](https://www.archlinux.site/2017/04/fontconfig.html)
- @2014 [Fontconfigことはじめ｜TechRacho by BPS株式会社](https://techracho.bpsinc.jp/baba/2014_01_27/15236)

# config

## fonts

`~/.fonts`
`/usr/local/share/fonts/`

## fonts.conf

`~/.config/fontconfig/fonts.conf`

## fc-cache

`update`

```
$ fc-cache -fv
# or ?
$ sudo fc-cache -fv
```

# query

## fc-list

[[xresource]]

```
xterm*faceName: Monoid:style=Regular:size=12:antialias=false
xterm*faceNameDoublesize: Yu Gothic:size=10
```

## fc-match

```
$ fc-match sans-serif
ipag.ttf: "IPAGothic" "Regular"
$ fc-match mono
ipag.ttf: "IPAGothic" "Regular"
```

# XFT

- [Xft - Wikipedia](https://ja.wikipedia.org/wiki/Xft)
- [伝統的なXのテキスト描画 (Xft) | Netsphere Laboratories](https://www.nslabs.jp/x11-draw-m17n-text.rhtml)
- [X.org Fonts General](https://xpt.sourceforge.net/techdocs/nix/x/fonts/xf18-XorgFontsGeneral/single/)

# Windows

- [日本語フォントの設定 | 逆襲のSlackware](https://slackware.jp/configuration/fonts.html)

```sh
# 空になる
$ fc-match --sort :lang=ja
$env:FC_DEBUG=1
```

```sh
# 動く
$ fc-list
```

```sh
$ fc-conflist
$env:FONTCONFIG_PATH="$HOME/.config/fontconfig"
```

```xml title="$HOME/.config/fontconfig/font.conf"
```

```sh
$ fc-cache -r
```
