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

# dotfiles
- @2023 [Neovim + Docker でローカルを汚さずに開発環境を構築](https://zenn.dev/tamago3keran/articles/30b581bde514e6)
- @2021 [Dockerでdotfilesのポータビリティーを高める開発環境構築](https://zenn.dev/_kazuya/articles/1c142f23741f15efd169)
- [VSCode Remote Containers を使うなら dotfiles repository で幸せになろう - Qiita](https://qiita.com/frozenbonito/items/aa320c4b3f84b9816daa)
- [VSCodeのRemote Containerでdotfilesを引き継ぐ方法](https://banatech.net/blog/view/33)
- [NeovimとDev Containerを使った開発環境の試行錯誤 · blog.bridgey.dev](https://blog.bridgey.dev/2023/02/19/neovim-devcontainer/#dev-container-cli)
- [VSCodeのDev Containersで開発環境構築のポイントをまとめてみた。 - Qiita](https://qiita.com/redgosho/items/8f2c7e138c54be50eac1)

# DevContainer
- [Development containers](https://containers.dev/)

- [Dev Containers - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

- [Developing inside a Container using Visual Studio Code Remote Development](https://code.visualstudio.com/docs/devcontainers/containers)
- [Devcontainer(Remote Container) いいぞという話 ~開発環境を整える~ - Qiita](https://qiita.com/yoshii0110/items/c480e98cfe981e36dd56)
- [VSCode Dev Containerを使った開発環境構築 | KINTO Tech Blog | キントテックブログ](https://blog.kinto-technologies.com/posts/2022-12-10-VSCodeDevContainer/)
- [VSCode Devcontainer 放浪記](https://zenn.dev/streamwest1629/articles/vscode_wanderer-in-devcontainer)
