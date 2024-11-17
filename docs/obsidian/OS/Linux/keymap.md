# ARCH

```
dumpkeys > nocaps.map
vim nocaps.map # 58 CapsLock => Control
sudo cp nocaps.map /usr/share/kbd/keymaps
sudo localectl set-keymap --no-convert nocaps
```

# evremap

[GitHub - wez/evremap: A keyboard input remapper for Linux/Wayland systems, written by @wez](https://github.com/wez/evremap)

# LinuxConsole

- @2022 [Waylandになる | endaaman.me](https://endaaman.me/tips/wayland)
- [まさおのブログ (表): CUI ログインで、CapsLock キーを Ctrl キーにする dumpkeys, loadkeys](http://masaoo.blogspot.com/2017/12/cui-capslock-ctrl-dumpkeys-loadkeys.html)

[Site Unreachable](https://golang.hateblo.jp/entry/ubuntu-keyboard-layout)
sudo dpkg-reconfigure keyboard-configuration

```
# loadkeys jp106
# dumpkeys -l
# loadkeys _keymap_
```

# right alt

キリル文字？

```vbnet
setxkbmap -option lv3:ralt_alt
```

# xorg

[[setxkbmap]]

- [101/104/109…キーボード配列、種類、構造についての解説と一覧 - uzurea.net](https://uzurea.net/keyborde-type-list/#104)

# pc101

# pc104

- pc101
- Super×2
- Meta×１

# 日本語106(OADG106)

- 変換
- 無変換
- カタカナ ひらがな
- 半角/全角
- ￥（通貨）

# 日本語 108 109

- 日本語106
- Super×2
- Meta×１

# xremap

[最強のキーリマッパーで、ラズパイBookwormのWayland環境を最強にする | Yagifulのブログ](https://yagiful.com/blog/raspi-bookworm-xremap/)


