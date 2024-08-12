# 0

`ssh-server`

```sh
$ sudo apt install openssh-server vim
$ ip addr
```

# 1st

```sh
$ sudo visudo
USER_NAME ALL=(ALL) NOPASSWD:ALL
$ sudo vim /etc/inputrc
"\C-n":history-search-forward
"\C-p":history-search-backward
$ exit
```

# 2nd

```sh
$ sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
$ sudo apt update && sudo apt upgrade -y
$ sudo apt install git dotnet-sdk-8.0 build-essential tmux curl
$ dotnet tool install --global PowerShell
$ SHELL=$HOME/.dotnet/tools/pwsh tmux
```

# 3rd

## /etc/wsl.conf

```ini
[interop]
appendWindowsPath = false
```

## npm

- [Ubuntu で Node の最新版/推奨版を使う (n コマンド編) #Node.js - Qiita](https://qiita.com/cointoss1973/items/c000c4f84ae4b0c166b5)

```sh
$ sudo apt install nodejs npm
$ sudo npm install n -g
$ sudo n lts
$ sudo apt purge nodejs npm
```

この辺で dotfiles 導入

# desktop

```sh
sudo apt install labwc foot pcmanfm
```
