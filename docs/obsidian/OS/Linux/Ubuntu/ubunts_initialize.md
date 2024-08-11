# 1st

`vim, tmux, sudo`

```sh
$ sudo visudo
$ sudo /etc/inputrc
"\C-n":history-search-forward
"\C-p":history-search-backward
$ exit
```

# 2nd

```sh
$ sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
$ sudo apt update && sudo apt upgrade -y
$ sudo install git dotnet-sdk-8.0 build-essential
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
