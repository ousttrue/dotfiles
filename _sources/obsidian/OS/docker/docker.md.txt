[[DockerDesktop]]
[[docker_install]]

```
$ systemctl status docker
```

# Version
## 17
`multi stage build`
- @2017 [Docker multi stage buildで変わるDockerfileの常識 - Qiita](https://qiita.com/minamijoyo/items/711704e85b45ff5d6405)

# cli
[docker | Docker ドキュメント](https://matsuand.github.io/docs.docker.jp.onthefly/engine/reference/commandline/docker/)
- @2017 [Dockerライトユーザーの為のコマンド一覧 - Qiita](https://qiita.com/hasegit/items/1e3d6d43b4356a74dfe1)

```
> docker --version
Docker version 24.0.5, build ced0996
```

## image
```
docker image ls
```

## container
```
docker container ls
```

## run
- shell login 
[dockerで特定ユーザでログインした状態のシェル環境を提供する](https://blog.mosuke.tech/entry/2015/01/24/213255/)

```
#$ docker run --rm -it -u "hoge:hoge" IMAGE_NAME
$ docker run --rm -it mydev su - hoge
# --rm: remove exists
# -i: interactive
# -t: tty
# -u: user:group
```

# mount
- [Docker の Volume がよくわからないから調べた - Qiita](https://qiita.com/aki_55p/items/63c47214cab7bcb027e0)
## volume
- [ボリュームの使用 — Docker-docs-ja 24.0 ドキュメント](https://docs.docker.jp/storage/volumes.html)
- [ボリュームの利用 | Docker ドキュメント](https://matsuand.github.io/docs.docker.jp.onthefly/storage/volumes/)

# Dockerfile
- @2018 [Dockerfileの書き方, 利用する命令, 作成手順 - わくわくBank](https://www.wakuwakubank.com/posts/270-docker-build-image/)

## build
```
$ docker image build -t イメージ名[:タグ名] [Dockerfileが配置されているディレクトリパス]
```

## ls
```
$ docker image ls
```

## run
```
$ docker container run -it centos:7 /bin/bash

$ docker run -v "$(pwd):/home/name" -u 1000 -t name ls
```

### mount
- [【Docker】Dockerでホストのディレクトリをマウントする - Qiita](https://qiita.com/Yarimizu14/items/52f4859027165a805630)
```
$ docker run -v [ホストディレクトリの絶対パス]:[コンテナの絶対パス] [イメージ名] [コマンド]
```

# docker-compose.yml

```yml
version: "3.8"

services:
  devcontainer:
    build:
      context: ..
      dockerfile: .devcontainer/Dockerfile
    volumes:
      - ..:/workspace:cached
      - gohome:/home/vscode/go:cached
    command: /bin/sh -c "while sleep 1000; do :; done"
    user: vscode
volumes:
  gohome:
```

# dotfiles
- @2023 [Neovim + Docker でローカルを汚さずに開発環境を構築](https://zenn.dev/tamago3keran/articles/30b581bde514e6)
- @2021 [Dockerでdotfilesのポータビリティーを高める開発環境構築](https://zenn.dev/_kazuya/articles/1c142f23741f15efd169)
- [VSCode Remote Containers を使うなら dotfiles repository で幸せになろう - Qiita](https://qiita.com/frozenbonito/items/aa320c4b3f84b9816daa)
- [VSCodeのRemote Containerでdotfilesを引き継ぐ方法](https://banatech.net/blog/view/33)
- [NeovimとDev Containerを使った開発環境の試行錯誤 · blog.bridgey.dev](https://blog.bridgey.dev/2023/02/19/neovim-devcontainer/#dev-container-cli)
- [VSCodeのDev Containersで開発環境構築のポイントをまとめてみた。 - Qiita](https://qiita.com/redgosho/items/8f2c7e138c54be50eac1)

[[DevContainers]]

# rootless
- [Ubuntu Serverにrootless Dockerをインストールする - みーのぺーじ](https://pc.atsuhiro-me.net/entry/2022/03/20/163744)
