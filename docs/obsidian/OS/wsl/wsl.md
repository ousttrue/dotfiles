- [WSLのWindowsのフォルダの色が見づらいのを直す - 新しいことにはウェルカム](https://www.kwbtblog.com/entry/2019/04/27/023411)

# Version

## 2.4.4

- @2025 [ArchLinuxをWSLにインストール(2025)](https://zenn.dev/dozo/articles/a0ef464bfd77f0)

## 2.0.9

- @2023 [WSL2 2.0.x正式版がこっそリリース](https://zenn.dev/dozo/articles/82e24c52e0ccdc)

# /etc/wsl.conf

```
[interop]
appendWindowsPath = false

[boot]
systemd=true
```

# systemd

- @2022 [WSL2+Ubuntu22.04に標準で入ったsystemdを試す - Qiita](https://qiita.com/shigeokamoto/items/ca2211567771cf40a90d)
- @2022 [「Windows Subsystem for Linux」が「systemd」に対応へ - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1441775.html)

# vscode

` /mnt/c/Users/USER_NAME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code`
でインストールできる。

## error

```
$ code
<3>WSL (6658) ERROR: UtilConnectUnix:510: connect failed 2
```

- @2021 [VSCode/WSL2/Docker の組み合わせで遭遇するエラーとその対策 - Qiita](https://qiita.com/iwaiktos/items/33ab69a42c3a1cc35dfb#3init-4010-error-utilconnecttointeropserver300-connect-failed-2)

# startup

```bat
wsl /bin/bash --login -c btm
```

# maintenance

## list --online

インストール可能の一覧

```sh
> wsl --list --online
```

## install

```sh
wsl --install Ubuntu22.04
```

初手

```sh
sudo apt install vim git unzip

sudo visudo
hoge ALL=NOPASSWD: ALL

sudo /etc/inputrc
"\C-n":history-search-forward
"\C-p":history-search-backward

sudo vim /etc/wsl.conf
[interop]
appendWindowsPath = false

curl -fsSL https://bun.sh/install | bash
```

## uninstall

```sh
wsl --unregister Ubuntu-22.04
```

image ごと消える。

- @2021 [グチャグチャになった「Ubuntu on WSL2」のやり直し方 #Ubuntu - Qiita](https://qiita.com/PoodleMaster/items/b54db3608c4d343d27c4)

## image

わりと大容量になる

%LOCALAPPDATA%/Packages/CanonicalGroupLimited.Ubuntu22.04LTS\_.../LocalState/ext4.vhdx => 30G
