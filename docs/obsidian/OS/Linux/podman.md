[[virtualization]]

- @2022 [WSL で使うのは Docker より Podman のほうが楽だった](http://var.blog.jp/archives/86620198.html)
- @2022 [WSL の Almalinux9 で Docker を動かす](http://var.blog.jp/archives/86618552.html)

- @2021 [【Podman】Goのビルドをコンテナ内で実行する](https://zenn.dev/tnk4on/articles/go-build-in-container)
```sh
> podman run --rm --env GOOS=windows --env GOARCH=amd64 -v .:/hello:z -w /hello golang go build
```

# podman-compose
- @2022 [docker-composeからの脱却。podman-composeからのPod化までの道 #docker-compose - Qiita](https://qiita.com/toomori/items/d461e607897aa8229166)
> py -m pip install podman-compose

# Version
## 4.8

# Desktop
- @2023 [WindowsにPodman Desktopを入れた後にIntelliJ IDEAと他のWSLから実行できるようにする - #chiroito ’s blog](https://b.chiroito.dev/entry/2023/04/21/104025)
> Podman Desktop を入れると WSL 上に `podman-machine-default` という Linux

- @2023 [Podman Desktopがv1.0になったのでwindows版を試してみたところ、気付いたらv1.1に上がるくらいに機能豊富だった話 | 豆蔵デベロッパーサイト](https://developer.mamezou-tech.com/blogs/2023/06/09/podman-desktop-win/)
- @2023 [Podman Desktop のインストール(for Windows) #Windows - Qiita](https://qiita.com/youn0810/items/4e7ca4050413f3c6df08)
- @2023 [Docker Desktopの代替 Podman Desktopを試してみた - HapInS Developers Blog](https://blog.hapins.net/entry/2023/11/10/083749)
- @2022 [Podman Desktopを試してみる - Qiita](https://qiita.com/hisato_imanishi/items/cdfd43165dae4a59d68e)
