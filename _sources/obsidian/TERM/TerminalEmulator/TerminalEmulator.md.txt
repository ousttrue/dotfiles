---
aliases: [X端末, xterm]
---
[[fontconfig]] [[TerminalGraphics]]

|app|config|xresources|fontconfig|sixel|
|-|-|-|-|-|
|xterm||O|Option|-ti 340|
|foot|||||
|kitty|||||
|wezterm|~/.config/wezterm/wezterm.lua|X||O|


- guake

# XWindow
[[XWindow]]
## xterm
[[TerminalEmulator|xterm]]

## urxvt
- @2017 [urxvt こと rxvt-unicode を使うことのメモ | Jenemal Notes](http://malkalech.com/urxvt_terminal_emulator)

## st
[[simple_terminal|st]]

# wayland
[[wayland]]
## foot
[dnkl/foot: A fast, lightweight and minimalistic Wayland terminal emulator - foot - Codeberg.org](https://codeberg.org/dnkl/foot)

- @2022 [速いターミナルfoot(について書こうとしたらtmuxが遅くて大差ないという記事)](https://zenn.dev/fuzmare/articles/foot-terminal)

# vte
[[vte]]

# OpenGL
## kitty
[[wayland]]

## wezterm
[[wayland]]

- [Build from source - Wez's Terminal Emulator](https://wezfurlong.org/wezterm/install/source.html)
```
vim wezterm-gui/Cargo.toml
```

- wayland-client
- wayland-protocol
- wayland-egl

## Alacritty
[[wayland]]
- [Alacritty - A cross-platform, OpenGL terminal emulator](https://alacritty.org/)
	- [alacritty/INSTALL.md at master · alacritty/alacritty · GitHub](https://github.com/alacritty/alacritty/blob/master/INSTALL.md)
```
# Force support for only X11
cargo build --release --no-default-features --features=x11
```

- @2018 [LinuxデスクトップのターミナルアプリとしてAlacrittyを使い始めた - ぶていのログでぶログ](https://tech.buty4649.net/entry/2018/07/30/134654)

## other
- [Zutty - Zero-cost Unicode Teletype](https://tomscii.sig7.se/zutty/)
- [GitHub - bolner/CRTerm: CRT Terminal emulator (OpenGL)](https://github.com/bolner/CRTerm)
- [GitHub - refi64/uterm: A WIP terminal emulator, written in C++11 using Skia, libtsm, and GLFW](https://github.com/refi64/uterm)

# libvterm
## pangoterm
- [pangoterm in Launchpad](https://launchpad.net/pangoterm)

----
#red

[[windows_terminal]]
[[multiplexer]]

[[vt100]]
[[font]]
[[terminfo]]
[[stdio]]
[[ioctl.h]]
[[termbox]]
[[termbox2]]

- [Text-Terminal-HOWTO](https://linuxjf.osdn.jp/JFdocs/Text-Terminal-HOWTO.html)
- [なぜ Control-/ がターミナルで使えないか調べたらターミナルの歴史を紐解くことになった](https://zenn.dev/takc923/articles/d2ec1fcd4ea66f)

# 入力: main loop

```c++
#include <termios.h>
```

[[libuv]] 使うべし

# .Xresource

`xrdb -merge .Xresources`

- [X resources を設定することのメモ | Jenemal Notes](http://malkalech.com/xresources_magic)

[[xft]] XFreeType
- [X11でのFontの設定(4) -Xftの設定-, X11でのFontの設定(5) -XTermの設定- - ここに日記はありません(2016-10-14)](http://onozaki.org/d/?date=20161014)
[[xterm]]
[[urxvt]]

# [[fontconfig]]
[[simple_terminal]]

# libvte
[[gnome-terminal]]
[[sakura]]

# GPU
- [[alacritty]]
- [[kitty]]
- [[wezterm]]
- [GitHub - liamg/darktile: Darktile is a GPU rendered terminal emulator designed for tiling window managers.](https://github.com/liamg/darktile)

# Other
[[mlterm]]
- [GitHub - 91861/wayst: A simple terminal emulator](https://github.com/91861/wayst)

# Windows
[[mintty]]
[[conemu]]

Linux
[[fbterm]]
[[yaft]]
[[kmscon]]
