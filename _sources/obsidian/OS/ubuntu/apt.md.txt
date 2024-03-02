[Ubuntuのapt mirrorの設定って結局どうすればいいの？](https://zenn.dev/ciffelia/articles/c394962a8f188a)

```sh
sudo sed -i.bak -r 's@http://(jp\.)?archive\.ubuntu\.com/ubuntu/?@https://ftp.udx.icscoe.jp/Linux/ubuntu/@g' /etc/apt/sources.list
```

