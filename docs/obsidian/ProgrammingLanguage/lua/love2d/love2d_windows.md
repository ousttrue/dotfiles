windows build

https://github.com/love2d/megasource

```sh
> ghq get https://github.com/love2d/megasource
> cd (ghq list -p megasource)
> git clone https://github.com/love2d/love libs/love
> vcenv
> cmake -G Ninja -S . -B build
```
