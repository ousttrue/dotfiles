- [Ubuntuを入手する | Ubuntu | Ubuntu](https://jp.ubuntu.com/download)

# Version
- [Ubuntu Cloud Images - the official Ubuntu images for public clouds, Openstack, KVM and LXD](https://cloud-images.ubuntu.com/)

## 23.10
- @2023 [第783回　Ubuntu 23.10の変更点 | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0783)
- @2023 [Ubuntu 23.10 その45 - Ubuntu 23.10の新機能と変更点・既知の問題 - kledgeb](https://kledgeb.blogspot.com/2023/10/ubuntu-2310-45-ubuntu-2310.html)

## 22.10 (Kinetic Kudu)
- @2022 [Ubuntu 22.04 on WSLをUbuntu 22.10にアップグレードした - ぶていのログでぶログ](https://tech.buty4649.net/entry/2022/10/21/175745)
- @2022 [第735回　Ubuntu 22.10の変更点 | gihyo.jp](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0735)
	- [[gnome]] `43`

## 22.04 LTS (Jammy Jellyfish)

## 20.04 LTS (Focal Fossa)

## 18.04 LTS (Bionic Beaver)

# apt
>apt-getでパッケージ管理もできますが、 Ubuntu14.04 からaptコマンドが推奨されています。

- [【Ubuntu】コマンド一発で「アーカイブミラー」を切り替えるには？【アプデ高速化】 | LFI](https://linuxfan.info/ubuntu-switch-archive-mirror-command)
- [ubuntu 20.04 リポジトリ変更 | 好きこそものの上手なれ](https://pg-fan.com/blog/ubuntu-20-04-apt)
```
sudo sed -i.org -e 's|archive.ubuntu.com|ubuntutym.u-toyama.ac.jp|g' /etc/apt/sources.list
```

## apt-file
- @2016 [apt-fileコマンドに感動した - Qiita](https://qiita.com/tukiyo3/items/8026ca0adb61cb8dc881)

# dev
```bash
sudo apt install build-essential
```

# desktop
```
sudo apt install ubuntu-desktop-minimal
```



