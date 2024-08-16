https://www.freedesktop.org/wiki/Software/systemd/logind/

> The daemon provides both a C library interface as well as a D-Bus interface

> ConsoleKit の後継？

# seatd

wayland で使う。

https://www.freedesktop.org/wiki/Software/systemd/multiseat/

> All hardware devices that are eligible to being assigned to a seat
> A device can be assigned to only one seat at a time

```sh
>  loginctl list-seats
SEAT
seat0
```

## seat0

```sh
> loginctl seat-status seat0|
```

DisplayManager はここで活動する。

> f a device is not assigned to any particular other seat it is implicitly assigned to the special default seat called "seat0".
> "seat0" always exists.

## multiseat

https://wiki.gentoo.org/wiki/Multiseat

- GPU


## udev

## display manager

`seat => session`

https://www.freedesktop.org/wiki/Software/systemd/writing-display-managers/

# session

> A session is bound to one or no seats
> Multiple sessions can be attached to the same seat, but only one of them can be active

## loginctl

- @2022 [Geeko Blog &raquo; /usr/bin/\*ctl なプログラムが何をするのかを試してみました(loginctl)](https://blog.geeko.jp/ribbon/3092)
- @2019 [loginctlでGUIセッションの情報を取得する - kkAyatakaのメモ帳。](https://kkayataka.hatenablog.com/entry/2019/03/03/215208)

```sh
loginctl show-session
```

## desktop
