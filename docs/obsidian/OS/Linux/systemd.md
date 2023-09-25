[[dbus]]

- [systemctl コマンド - Qiita](https://qiita.com/sinsengumi/items/24d726ec6c761fc75cc9)
- @2019 [これからSystemd入門する - Qiita](https://qiita.com/bluesDD/items/eaf14408d635ffd55a18)

`initプロセス`
> systemdはカーネルによって最初に起動されるプログラムです。一番最初に起動するのでプロセスIDは１です。

# list
```
systemctl list-unit-files -t service
```

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
