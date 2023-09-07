[[docker]]
[[nvim_docker]]

# CreateImage
- [イメージの構築 — Docker-docs-ja 1.9.0b ドキュメント](https://docs.docker.jp/engine/userguide/dockerimages.html)
- [Create a base image | Docker Docs](https://docs.docker.com/build/building/base-images/)

## hello
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

## basic
- @2020 [Dockerfileを用いた初期設定：ユーザ追加 - アメリエフの技術ブログ](https://staffblog.amelieff.jp/entry/2020/07/09/130000)
```Dockerfile
From centos:7
ARG username=hoge

RUN yum -y install sudo
RUN useradd -m ${username}
RUN echo "${username}:${username}" | chpasswd
RUN echo "${username} ALL=NOPASSWD: ALL" >> /etc/sudoers
```

## c++ dev
`1.18G`
```Dockerfile
From centos:7
ARG username=hoge

RUN yum -y install python3
RUN pip3 install --upgrade pip
RUN pip3 install meson ninja cmake ziglang

RUN <<__EOF__
cat <<__CAT__ >> /etc/inputrc
"\C-n":history-search-forward
"\C-p":history-search-backward
set bell-style none
__CAT__
__EOF__

#
# USER
#
RUN yum -y install sudo
RUN useradd -m ${username}
RUN echo "${username}:${username}" | chpasswd
RUN echo "${username} ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN <<__EOF__
cat <<\__CAT__ > /home/${username}/.bash_profile
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/lib64/python3.6/site-packages/ziglang

export PATH
__CAT__
__EOF__

```

## SHELL
- [Dockerfileでビルド時にbashを使う - Qiita](https://qiita.com/anagura0000/items/bef08bf129f1bd8529ce)

# docker build
## tag
```
-t, --tag stringArray Name and optionally a tag (format: "name:tag")
```

