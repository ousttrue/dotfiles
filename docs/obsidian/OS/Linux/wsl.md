[[wslg]]
[[Linux]]
[[wsl_windows_side]]


# /etc/wsl.conf
```
[user]
default=ousttrue

[network]
hostname=wgentoo

[interop]
appendWindowsPath = false

[boot]
systemd=true
```
- @2022 [WSL2+Ubuntu22.04に標準で入ったsystemdを試す - Qiita](https://qiita.com/shigeokamoto/items/ca2211567771cf40a90d)
- @2022 [「Windows Subsystem for Linux」が「systemd」に対応へ - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1441775.html)

# app
## vscode
` /mnt/c/Users/USER_NAME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code`
でインストールできる。

### error
```
$ code
<3>WSL (6658) ERROR: UtilConnectUnix:510: connect failed 2
```
- @2021 [VSCode/WSL2/Docker の組み合わせで遭遇するエラーとその対策 - Qiita](https://qiita.com/iwaiktos/items/33ab69a42c3a1cc35dfb#3init-4010-error-utilconnecttointeropserver300-connect-failed-2)
