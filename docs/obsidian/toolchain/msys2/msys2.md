EXTFAT あかん w
[Installing binutils always can't create items · Issue #2631 · msys2/MSYS2-packages · GitHub](https://github.com/msys2/MSYS2-packages/issues/2631)

[MSYS2](https://www.msys2.org/)

-https://qiita.com/yumetodo/items/d849a6dcf08e0435f815

- @2021 [Windows 10 Pro で MSYS2 を出来る限り高速化する](https://zenn.dev/nyarla/articles/489394cec0ecb5)
- [Python x64 & MinGW64 環境の構築 | Wizard in the Market](https://fx-kirin.com/python/windows-python-mingw64-environment-build/)
- @2019 [ちよぶろ。: 最終的にMSYS2へ。](https://chiyosuke.blogspot.com/2019/03/msys2.html)
- @2017 [CmderでMSYS2の環境を構築してみる - zyzyz's Playground](https://zyzyz.github.io/ja/2017/10/Integrate-MSYS2-into-Cmder/)
- @2016 [MSYS2で快適なターミナル生活 - Qiita](https://qiita.com/Ted-HM/items/4f2feb9fdacb6c72083c)

# version

# $MSYSTEM

## UCRT64

# setup

- https://engineering.mobalab.net/2023/09/06/unix-like-environment-in-windows-using-msys2/

## /etc/pacman.conf

```sh
$ pacman -S vim git tmux
$ vim /etc/pacman.conf
```

```
#[clangarm64]
#Include = /etc/pacman.d/mirrorlist.mingw

#[mingw32]
#Include = /etc/pacman.d/mirrorlist.mingw

[mingw64]
Include = /etc/pacman.d/mirrorlist.mingw

#[ucrt64]
#Include = /etc/pacman.d/mirrorlist.mingw

#[clang32]
#Include = /etc/pacman.d/mirrorlist.mingw

#[clang64]
#Include = /etc/pacman.d/mirrorlist.mingw

[msys]
Include = /etc/pacman.d/mirrorlist.msys
```

```sh
$ pacman -Syu
```

# LOGINSHELL

- [MSYS2のログインシェルをzshに変更する（msys2-launcher対応版） - Qiita](https://qiita.com/from_kyushu/items/406c62d8d83240d4ffff)

# MSYSTEM

- [Environments - MSYS2](https://www.msys2.org/docs/environments/)

## /msys2.ini

```
#MSYS=winsymlinks:nativestrict
#MSYS=error_start:mingw64/bin/qtcreator.exe|-debug|<process-id>
#CHERE_INVOKING=1
#MSYS2_PATH_TYPE=inherit
MSYSTEM=MSYS
```

### pty

[[git_for_windows]]

```
MSYS=enable_pcon
```

## msys

```
> grep CHOST /etc/makepkg.conf
CHOST="x86_64-pc-msys"
```

- @2018 [MSYS2 環境に Go言語(golang) をインストール - takaya030の備忘録](https://takaya030.hatenablog.com/entry/2018/01/18/230105)

```
msys2.exe   --> msys2_shell.cmd -msys
```

### APPS

[[TerminalEmulator|console]] アプリはこれで入れるべし

```
MSYS=winsymlinks:nativestrict
```

`winpty` ?

- bash-5.2
- tmux-3.3
- w3m
- sixel ?
- vim

- nvim はビルドできない(luajit)

## ucrt

- [msys2でucrtのランタイムを使おう！ようこそucrt64 - Qiita](https://qiita.com/yumetodo/items/d849a6dcf08e0435f815)

## clang64

- [Msys2のclangを9.0から12.0に更新する | うどんコード](https://udon.little-pear.net/msys2-clang-update-from9-to12/)
  `MSYSTEM=CLANG64`

## MINGW64

    - mingw-w64-x86_64-toolchain
    - `C:\msys64\mingw64`

```
mingw64.exe --> msys2_shell.cmd -mingw64
mingw-w64-x86_64-toolchain
```

# fstab

```
# /etc/fstab
# DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
none / cygdrive binary,posix=0,noacl,user 0 0

C:/Users /home
```

# clipboard

- [MSYSで標準出力をクリップボードにコピー - プログラムdeタマゴ](https://nodamushi.hatenablog.com/entry/2018/01/12/195253)

## /dev/clipboard

- [MSYS2環境でtmuxとクリップボードの共有 - Qiita](https://qiita.com/hiratara/items/28cecb8b94dc83270dbc)

## win32yank

- [GitHub - equalsraf/win32yank: Windows clipboard tool](https://github.com/equalsraf/win32yank)
- [WSL vim/neovimとwin32yankの設定 - Qiita](https://qiita.com/tMinamiii/items/0c6589806090c7fc3f8a)
- [Neovim on WSL2で、win32yankを導入してクリップボードの共有と遅延問題を解決](https://zenn.dev/shoseisan/articles/d7565884f5846b)

# tmux build

## patch

[Index of /msys/sources/](https://repo.msys2.org/msys/sources/)
