[[wslg]]
[[Linux]]

# distribution 管理

```
> wsl --list --verbose
  NAME               STATE           VERSION
* Arch               Stopped         2
  Ubuntu-CommPrev    Stopped         2
```

## 削除

```
> wsl --unregister
```

## install

```
> wsl --list --online
インストールできる有効なディストリビューションの一覧を次に示します。
'wsl --install -d <Distro>' を使用してインストールします。

NAME            FRIENDLY NAME
Ubuntu          Ubuntu
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS
```

## import
root file system の tar を import する

- @2020 [WSL(2)でOSを手動で無限に追加（インポート）する方法 - 技術的な何か。](https://level69.net/archives/27563)
- @2020 [ストアアプリではない方法でディストリビューションを導入 - Qiita](https://qiita.com/matarillo/items/77d960d440fd19d7e533)
- [WSL にインストール - ArchWiki](https://wiki.archlinux.jp/index.php/WSL_%E3%81%AB%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

```
> wsl --import <DistributionName> <InstallLocation> <FileName> --version 2
```

[[gentoo]]
```
> wsl --import Gentoo ${env:USERPROFILE}\AppData\Local\WSL\Gentoo\ .\stage3-amd64-openrc-20211121T170545Z.tar --version 2
```

# /etc/wsl.conf

```
[user]
default=ousttrue

[network]
hostname=wgentoo

[interop]
appendWindowsPath = false
```

# vscode
` /mnt/c/Users/USER_NAME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code`
でインストールできる。
