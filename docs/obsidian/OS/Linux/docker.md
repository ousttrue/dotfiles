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
