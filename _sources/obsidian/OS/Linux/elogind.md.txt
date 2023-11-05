[[LoginManager]]
[[LoginSession]]
[[systemd]]
[[greetd]]

[elogind - Gentoo Wiki](https://wiki.gentoo.org/wiki/Elogind)
> **elogind** is the [systemd](https://wiki.gentoo.org/wiki/Systemd "Systemd") project's [_logind_](https://en.wikipedia.org/wiki/Systemd#logind "wikipedia:Systemd"), extracted to a standalone package

```/etc/portage/make.conf
USE="elogind -systemd"
```

```
# emerge --ask --changed-use --deep @world
[ebuild   R    ] sys-process/procps-3.3.17-r1  USE="elogind*"
[ebuild   R    ] sys-auth/seatd-0.7.0-r1  USE="elogind*"
[ebuild   R    ] sys-apps/dbus-1.15.2  USE="elogind*"
[ebuild   R    ] x11-base/xorg-server-21.1.4  USE="elogind*"
[ebuild   R    ] media-sound/pulseaudio-daemon-16.1  USE="elogind*"
```

- @2021 [Plamo Linux の elogind 対応](https://zenn.dev/tenforward/articles/aad089940a1277)
- @2019 [2019年3月28日　systemdフリーをあきらめない ―Gentoo、テストブランチでGNOME 3.30をinitで動かす | gihyo.jp](https://gihyo.jp/admin/clip/01/linux_dt/201903/28)

# dbus
[[dbus]]
dbus が elogind と連携する
```sh:~/.xinitrc
exec dbus-launch --exit-with-session <WINDOW_MANAGER>
```

# PulseAudio
[[PulseAudio]]
