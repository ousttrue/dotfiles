[[PackageManager]]
[[msys2]]

- [Arch Linux: pacmanの設定](https://zenn.dev/ohno418/articles/13e3472860881d)
- @2016 [Pacmanの使い方 - Qiita](https://qiita.com/MoriokaReimen/items/dbe1448ce6c0f80a6ac1)


```
$ pacman -Syu
-S sync
-y update
-u upgrade
```

# update
```sh
# sync refresh
$ sudo pacman -Sy

# sync upgrade
$ sudo pacman -Su

# both
$ sudo pacman -Syu
```

## pacman-key
- @2020 [1 年ぶりくらいに pacman でパッケージ更新しようとしたらエラーになった](https://zenn.dev/miwarin/articles/e0ca2e9d78a1614fe296)

# /etc/pacman.conf

- color コメントイン
- 使わない種類をコメントアウト
```
Color 

#[mingw64] 
#Include = /etc/pacman.d/mirrorlist.mingw64
```

## mirror
- [MSYS2国内源 · GitHub](https://gist.github.com/elvisw/cc00088e9c8fd1c83aca)
- [msys2のミラーにjaistを使いたい - Qiita](https://qiita.com/yumetodo/items/94a80ca9d6171e9352a2)
`/etc/pacman.d/mirrorlist`

```
$ pacman-mirrors --fasttrack 5
$ pacman -Syu
```

```
$ pacman -g
```

# install

# uninstall

```
$ pacman R vim
```

# search
```sh
# sync search
$ sudo pacman -Ss vim
```

# local
```sh
# query search
$ sudo pacman -Qs vim
```

# local install
```sh
$ sudo pacman -U
```

# tool
## yay
- [GitHub - Jguer/yay: Yet another Yogurt - An AUR Helper written in Go](https://github.com/Jguer/yay)

## pacseek
- [GitHub - moson-mo/pacseek: A terminal user interface for searching and installing Arch Linux packages](https://github.com/moson-mo/pacseek)

## cylon
- [GitHub - gavinlyonsrepo/cylon: A Terminal user interface for maintaining an Arch Linux distribution.](https://github.com/gavinlyonsrepo/cylon)

# packages
## base-devel

```
$ pacman -S base-devel
$ pacman -S mingw-w64-i686-toolchain
```
