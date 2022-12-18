[[wslg]] [[RDP]] [[KMS]]

#red

- [Wayland](https://wayland.freedesktop.org/docs/html/index.html)
	- [Wayland Desktop Landscape - Gentoo Wiki](https://wiki.gentoo.org/wiki/Wayland_Desktop_Landscape)


- @2016 [Wayland の Client と Compositor の概念を理解する - Qiita](https://qiita.com/naohikowatanabe/items/06a8b988b89b4b1ec899)
- @2016 [Waylandとは？ - Qiita](https://qiita.com/maueki/items/9a3a8791a05c00b34c29)
- @2012 [Wayland Overview – Qt のあれこれ (仮)](https://qt-labs.jp/2012/12/wayland-overview.html)

# dev
## compositor
- @2018 [作って学ぶWayland - Qiita](https://qiita.com/maueki/items/34323b2762e3c3342c51)

## client
- @2018 [[OpenGLES]] [tutorials/wayland-egl.c at master · eyelash/tutorials · GitHub](https://github.com/eyelash/tutorials/blob/master/wayland-egl.c)
- @2017 [Wayland に EGL で三角を描く - Qiita](https://qiita.com/propella/items/7eab945158e8284bf778)
- @2017 [Wayland の shm にビットマップで絵を描く - Qiita](https://qiita.com/propella/items/d180dd0425ecd99efd42)
- @2016 [Wayland を使って描画テスト＆入力 – すらりん日記](https://blog.techlab-xe.net/post-4621/)
- @2014 [Waylandプログラミング入門 - ブログのタイトル](http://d.hatena.ne.jp/devm33/20140422/1398182440)
- [Wayland プログラミング](https://aznote.jakou.com/prog/wayland/index.html)

# backend
## RDP
[[RDP]]
- @2017 [Wayland RDP backend試してみた - Qiita](https://qiita.com/junjihashimoto@github/items/2c37ee557360a6459926)

# Compositor(Server)
[[wayland_compositor]]

# libseat
- [seatd: Seat management daemon and library](https://sr.ht/~kennylevinsen/seatd/)
session
`seatd`

# Display
`WAYLAND_DISPLAY=wayland-0`
`export XDG_RUNTIME_DIR=/tmp`

# Input
- [Device quirks — libinput 1.22.0 documentation](https://wayland.freedesktop.org/libinput/doc/latest/device-quirks.html)

# xdg-shell
- [xdg-shell | Clean Rinse](http://blog.mecheye.net/2014/06/xdg-shell/)
- [Wayland xdg-shell protocol - Tizen Wiki](https://wiki.tizen.org/Wayland_xdg-shell_protocol)

# カーソル消える
`export WLR_NO_HARDWARE_CURSORS=1`
