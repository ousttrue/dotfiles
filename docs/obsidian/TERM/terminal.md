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

# [[FontConfig]]
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
