[[nvim_build]]

```Dockerfile
FROM ubuntu:22.04-slim
#FROM ubuntu:22.04
ARG username=hoge

# root
RUN apt update
RUN apt install -y curl git build-essential unzip gettext cmake ninja-build

# add user
RUN apt install -y sudo
RUN useradd -m ${username}
RUN echo "${username}:${username}" | chpasswd
RUN echo "${username} ALL=(ALL) ALL" >> /etc/sudoers

# user
USER ${username}
WORKDIR /home/${username}
RUN curl -L -O https://github.com/neovim/neovim/archive/refs/tags/v0.9.2.tar.gz
RUN ls -al
RUN tar xf v0.9.2.tar.gz
WORKDIR /home/${username}/neovim-0.9.2
RUN cmake -G Ninja -S cmake.deps -B .deps -DCMAKE_BUILD_TYPE=Release 
RUN cmake --build .deps && cmake --install .deps
RUN cmake -G Ninja -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/${username}/build/neovim
RUN cmake --build build && cmake --install build

CMD ["/bin/bash"]

# docker build -tag nvim .
# docker run --rm -it -u hoge:hoge nvim
```
800MB

# nvim-remote-container
https://github.com/jamestthompson3/nvim-remote-containers

# nvim-dev-container
https://github.com/esensar/nvim-dev-container

# lazydocker
- [Neovim 101— Docker. Managing docker containers using… | by alpha2phi | Medium](https://alpha2phi.medium.com/neovim-101-docker-b133d5db04a2)

# ENTRYPOINT
[[nvim]]
- @2023 [環境を汚さずにdockerでneovim環境を構築する](https://zenn.dev/taro0079/articles/5049929bf62376)
- @2018 [yukimemi's blog - Use neovim in docker](https://yukimemi.netlify.app/use-neovim-in-docker/)
