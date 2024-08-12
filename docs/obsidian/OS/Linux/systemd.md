- https://wiki.gentoo.org/wiki/OpenRC_to_systemd_Cheatsheet/ja

- @2023 [systemctlとsysctlの違い #初心者 - Qiita](https://qiita.com/For_Whom_The_Alarm_Tolls/items/e1b7bc6b630f74f78f63)
- @2019 [systemctl コマンド - Qiita](https://qiita.com/sinsengumi/items/24d726ec6c761fc75cc9)
- @2019 [これからSystemd入門する - Qiita](https://qiita.com/bluesDD/items/eaf14408d635ffd55a18)

`initプロセス`

> systemdはカーネルによって最初に起動されるプログラムです。一番最初に起動するのでプロセスIDは１です。

`systemctl` が systemd。`sysctrl` はカーネル機能。

# list

```
systemctl list-unit-files -t service
```

# unit

## user level

`~/.config/systemd/user/mpd.service`

https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC#.E3.83.A6.E3.83.BC.E3.82.B6.E3.83.BC.E3.83.A6.E3.83.8B.E3.83.83.E3.83.88.E3.82.92.E6.9B.B8.E3.81.8F

- [ユーザレベルで systemd のユニットファイルを書くときの注意点](https://zenn.dev/noraworld/articles/systemd-unit-files-user-level-tips)
- @2019 [systemd のユニットファイルの作り方 | 晴耕雨読](https://tex2e.github.io/blog/linux/create-my-systemd-service)

# /var/log/journal

ログ
`$ sudo journalctl -f -u サービス名`

# systemctl

- @2017 [systemctl コマンド - Qiita](https://qiita.com/sinsengumi/items/24d726ec6c761fc75cc9)

## user

- @2022 [cron で systemctl --user を使う方法 (Failed to connect to bus... の解決法)](https://zenn.dev/noraworld/articles/systemctl-user-cron)
- @2020 [ユーザー権限のsystemdにFailed to connect to busで繋がらない時の対処方法 - @znz blog](https://blog.n-z.jp/blog/2020-06-02-systemd-user-bus.html)

# WSL

- [「Windows Subsystem for Linux」が「systemd」に対応へ - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1441775.html)
- @2022 [Distrodを使うのをやめました - @ledsun blog](https://ledsun.hatenablog.com/entry/2022/10/28/182104)

```
# /etc/wsl.conf
[boot]
systemd=true
```

## Ubuntu

`genie`

- @2022 [【WSL2】systemctlが動かない問題をきちんと解決する | しきゆらの備忘録](https://shikiyura.com/2020/06/execute_systemctl_on_wsl2/)

## Arch

`distord`

- @2021 [Arch Linux on WSL2 で systemd を動かす - gifnksmの雑多なメモ](https://gifnksm.hatenablog.jp/entry/2021/01/02/183830)

# user service

- https://wiki.archlinux.jp/index.php/Systemd/%E3%83%A6%E3%83%BC%E3%82%B6%E3%83%BC

## セッシオン維持

```sh
sudo loginctl enable-linger username
```
