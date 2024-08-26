- [クリップボードの形式 - Win32 apps | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/win32/dataxchg/clipboard-formats)

# neovim

- [wsl2のneovimでWindows側とクリップボード共有をする - Qiita](https://qiita.com/yuta_vamdemic/items/331f4d9a1522f2edcf21)

# docker

- [Dockerコンテナ内でVimのYank(コピー)をホストマシーンのクリップボードにコピーした方法 - Qiita](https://qiita.com/hellomyzn/items/8f1fbfe1316decf36a9e)

# wayland

- [GitHub - bugaevc/wl-clipboard: Command-line copy/paste utilities for Wayland](https://github.com/bugaevc/wl-clipboard)

# kde

- https://userbase.kde.org/Klipper

# x11

- @2019 [ヤンク履歴管理する仕組みを作った | endaaman.me](https://endaaman.me/tips/smart-yank-history)

# rofi

## greenclip

https://zenn.dev/syui/articles/archlinux-sway-wm-i3-change

- [Greenclip - ArchWiki](https://wiki.archlinux.jp/index.php/Greenclip)

```sh
# read from clipboard
xclip -o -selection c

# write to clipboard
echo "Hi there!" | xclip -i -selection c
```

# cygwin

`/dev/clipboard`

- @2012 [cygwin vim でクリップボードを使う #Vim - Qiita](https://qiita.com/usamik26/items/f27fef5335752a3e37ec)

# ubuntu

- https://github.com/SenpaiSilver/dev_clipboard

# osx

`pbcopy`
