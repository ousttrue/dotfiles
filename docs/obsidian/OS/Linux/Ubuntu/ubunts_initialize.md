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
