[[Desktop]]

- @2018 [DBus ことはじめ - Qiita](https://qiita.com/byuu/items/c600366b9c138f639863)
- @2017 [D-Bus のはなし｜Wireless・のおと｜サイレックス・テクノロジー株式会社](https://www.silex.jp/blog/wireless/2017/01/d-bus.html)

# WSL
[[systemd]]


# busctrl
- @2022 [D-Busと少し仲良くなろう | スクエニ ITエンジニア ブログ](https://blog.jp.square-enix.com/iteng-blog/posts/00022-get-familiar-with-d-bus/)

```
$ busctl
Failed to connect to bus: No such file or directory
```

# Ubuntu

```
apt install dbus-x11
sudo service dbus start
```

# session
```
dbus-launch bash
dbus-run-session
```

# command

```
dbus-send --print-reply --system --dest=org.freedesktop.DBus / --type=method_call org.freedesktop.DBus.ListNames

dbus-send --print-reply --system --dest=org.bluez / --type=method_call org.freedesktop.DBus.Introspectable.Introspect
dbus-send --print-reply --system --dest=org.bluez /org --type=method_call org.freedesktop.DBus.Introspectable.Introspect

dbus-send --print-reply --system --dest=org.bluez /org/bluez/hci0 --type=method_call org.bluez.Adapter1.StartDiscovery

dbus-send --print-reply --system --dest=org.bluez /org/bluez/hci0 --type=method_call org.freedesktop.DBus.Properties.GetAll string:org.bluez.Adapter1
```

# WSL
[[OS/Linux/wsl]]
- @2019 [WSL（CentOS7）でsystemctlを実行するとFailed to get D-Bus connection: Operation not permittedになる - Qiita](https://qiita.com/mzmiyabi/items/fec2c211e0325a5460a8)

# DBus-Next
[Python DBus-Next Documentation — dbus-next 0.2.3 documentation](https://python-dbus-next.readthedocs.io/en/latest/)

- [GitHub - altdesktop/playerctl: 🎧 mpris media player command-line controller for vlc, mpv, RhythmBox, web browsers, cmus, mpd, spotify and others.](https://github.com/altdesktop/playerctl)
- [GitHub - altdesktop/i3-dstatus: Another great statusline generator for i3wm](https://github.com/altdesktop/i3-dstatus)

# dbus-python 
- [dbus-python tutorial — dbus-python 1.2.18 documentation](https://dbus.freedesktop.org/doc/dbus-python/tutorial.html)
- [4. D-Bus 使用 — big-doc 0.1 documentation](https://thebigdoc.readthedocs.io/en/latest/dbus/index.html)



# service name(bus name)

# D-Feet
- [D-Feetを使ってDBusインターフェースの変更に追従するには - 2020-08-20 - ククログ](https://www.clear-code.com/blog/2020/8/20.html)

# WSL
- [Ubuntu 18.04のWSL上へのインストールと初期設定](https://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToInstallUbuntu1804OnWSL.html)
- [お前らのWSLはそれじゃダメだ - たいちょーの雑記](https://xztaityozx.hatenablog.com/entry/2017/12/01/001544)
- [最強の WSL 環境を作る](https://zenn.dev/masakura/articles/8d05c70c35b0d7)

# Windows
- [GitHub - uglide/dbus-python-windows: Python bindings for D-Bus IPC mechanism with CMake build & Windows binaries](https://github.com/uglide/dbus-python-windows)


