[[wslg]] [[RDP]] [[KMS]]

- [Wayland](https://wayland.freedesktop.org/docs/html/index.html)

  - [Wayland Desktop Landscape - Gentoo Wiki](https://wiki.gentoo.org/wiki/Wayland_Desktop_Landscape)

- @2016 [Wayland の Client と Compositor の概念を理解する - Qiita](https://qiita.com/naohikowatanabe/items/06a8b988b89b4b1ec899)
- @2016 [Waylandとは？ - Qiita](https://qiita.com/maueki/items/9a3a8791a05c00b34c29)
- @2012 [Wayland Overview – Qt のあれこれ (仮)](https://qt-labs.jp/2012/12/wayland-overview.html)

# caps to ctrl

https://github.com/rvaiya/keyd

# display

`/sys/class/display`

- `card1-HDMI-A-1`

# driver

DRM で OpenGL か Vulkan を作って描画したいが、`nvidia` ドライバが無かった。
`xorg` 向けはあった?

- [NVIDIA reveal a list of issues with their driver and Wayland | GamingOnLinux](https://www.gamingonlinux.com/2022/05/nvidia-reveal-a-list-of-issues-with-their-driver-and-wayland/?fbclid=IwAR3bpnk-0N1GkI7RWyz91ndSos64t4gOEwjG0Ryi_41gg5VL-TfBT7-uaYA)

## ubuntu

- @2022 [NVIDIAドライバーが入っているUbuntuでWaylandを使う - Qiita](https://qiita.com/k0kubun/items/c1162098cbd7eba1bed0)

## intel

`i915`
[drm / igt-gpu-tools · GitLab](https://gitlab.freedesktop.org/drm/igt-gpu-tools)

linux-firmware linux-headers dkms intel-ucode

# env

`export GDK_BACKEND=wayland`

# dev

## compositor

[[wayland_compositor]]

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

- group: seat
- `systemctrl enable seatd.service`
- `systemctrl start seatd.service`

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

# term

## foot

[dnkl/foot: A fast, lightweight and minimalistic Wayland terminal emulator - foot - Codeberg.org](https://codeberg.org/dnkl/foot)

- @2022 [速いターミナルfoot(について書こうとしたらtmuxが遅くて大差ないという記事)](https://zenn.dev/fuzmare/articles/foot-terminal)

# session

`/usr/share/wayland-sessions/sway.desktop`
