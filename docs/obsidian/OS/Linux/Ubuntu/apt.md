@2022 [Ubuntuのapt mirrorの設定って結局どうすればいいの？](https://zenn.dev/ciffelia/articles/c394962a8f188a)

```sh
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
```

> apt-getでパッケージ管理もできますが、 Ubuntu14.04 からaptコマンドが推奨されています。

- [【Ubuntu】コマンド一発で「アーカイブミラー」を切り替えるには？【アプデ高速化】 | LFI](https://linuxfan.info/ubuntu-switch-archive-mirror-command)
- [ubuntu 20.04 リポジトリ変更 | 好きこそものの上手なれ](https://pg-fan.com/blog/ubuntu-20-04-apt)

```
sudo sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list
```

## apt-file

- @2016 [apt-fileコマンドに感動した - Qiita](https://qiita.com/tukiyo3/items/8026ca0adb61cb8dc881)
