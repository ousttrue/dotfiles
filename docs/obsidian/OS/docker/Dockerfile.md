[[docker]]

# CreateImage
- [イメージの構築 — Docker-docs-ja 1.9.0b ドキュメント](https://docs.docker.jp/engine/userguide/dockerimages.html)
- [Create a base image | Docker Docs](https://docs.docker.com/build/building/base-images/)

```Dockerfile
FROM scratch # base
ADD hello / # local の hello を copy

CMD ["/hello"] # run したときに実行？
```

```
# local に hello が必用
$ gcc -o hello -static hello.c
$ ldd hello
        not a dynamic executable
$ docker build --tag hello .
```

## SHELL
- [Dockerfileでビルド時にbashを使う - Qiita](https://qiita.com/anagura0000/items/bef08bf129f1bd8529ce)

# docker build
## tag
```
-t, --tag stringArray Name and optionally a tag (format: "name:tag")
```

