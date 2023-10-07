---
aliases: [X11, xorg]
---

[[TerminalEmulator]]


#red

[[statusbar]]
[[launcher]]
[[openbox]]
[[xfce4]]
[[xterm]]
[[dbus]]
[[PulseAudio]]

# keymap
- [Xorg でのキーボード設定 - ArchWiki](https://wiki.archlinux.jp/index.php/Xorg_%E3%81%A7%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E8%A8%AD%E5%AE%9A)

`setxkbmap -print -verbose 10`
`setxkbmap us`
`setxkbmap jp`

setxkbmap -query | grep layout

# ibus で setxkbmap jp

- @2015 [続・GNOME 3.14でキーボードレイアウトがjpにならない](https://www.archlinux.site/2015/01/gnome-314jp.html)

advanced の
- [ ] `use system keyboard layout` を使うべし！
