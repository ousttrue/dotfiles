[[pacman]]

EXTFAT あかん w
[Installing binutils always can't create items · Issue #2631 · msys2/MSYS2-packages · GitHub](https://github.com/msys2/MSYS2-packages/issues/2631)

[MSYS2](https://www.msys2.org/)

- @2021 [Windows 10 Pro で MSYS2 を出来る限り高速化する](https://zenn.dev/nyarla/articles/489394cec0ecb5)
- [Python x64 & MinGW64 環境の構築 | Wizard in the Market](https://fx-kirin.com/python/windows-python-mingw64-environment-build/)
- @2019 [ちよぶろ。: 最終的にMSYS2へ。](https://chiyosuke.blogspot.com/2019/03/msys2.html)
- @2017 [CmderでMSYS2の環境を構築してみる - zyzyz's Playground](https://zyzyz.github.io/ja/2017/10/Integrate-MSYS2-into-Cmder/)
- @2016 [MSYS2で快適なターミナル生活 - Qiita](https://qiita.com/Ted-HM/items/4f2feb9fdacb6c72083c)

# MSYSTEM
## msys
[[TerminalEmulator|console]] アプリはこれで入れるべし
- @2018 [MSYS2 環境に Go言語(golang) をインストール - takaya030の備忘録](https://takaya030.hatenablog.com/entry/2018/01/18/230105)
## ucrt
- [msys2でucrtのランタイムを使おう！ようこそucrt64 - Qiita](https://qiita.com/yumetodo/items/d849a6dcf08e0435f815)
## clang
- [Msys2のclangを9.0から12.0に更新する | うどんコード](https://udon.little-pear.net/msys2-clang-update-from9-to12/)

# pty
[[git_for_windows]]
```
MSYS=enable_pcon
```

# first
```sh
$ pacman -S vim git tmux
```

## /etc/pacman.conf
```sh
$ vim /etc/pacman.conf
```
`ucrt64` で行こう
```
#[clangarm64]
#Include = /etc/pacman.d/mirrorlist.mingw

#[mingw32]
#Include = /etc/pacman.d/mirrorlist.mingw

#[mingw64]
#Include = /etc/pacman.d/mirrorlist.mingw

[ucrt64]
Include = /etc/pacman.d/mirrorlist.mingw

#[clang32]
#Include = /etc/pacman.d/mirrorlist.mingw

#[clang64]
#Include = /etc/pacman.d/mirrorlist.mingw

[msys]
Include = /etc/pacman.d/mirrorlist.msys
````

```sh
$ pacman -Syu
```

## MSYSTEM=msys で運用
- msys gcc をデフォルト
- ucrt clang を meson 開発に使う

# second
## pacman
```
$ pacman -S gcc unzip make cmake
```

## pip

## go
### ghq
### fzf
### pacseek
### nyagos

## rust
### zoxide

# fstab
```
# /etc/fstab
# DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
none / cygdrive binary,posix=0,noacl,user 0 0

C:/Users /home
```


# $MSYSTEM
- [Environments - MSYS2](https://www.msys2.org/docs/environments/)
- MSYS
- MINGW64
	- mingw-w64-x86_64-toolchain
	- `C:\msys64\mingw64`
- MINGW32
	- mingw-w64-i686-toolchain
- Clang32
- Clang64
- Ucrt64
`MSYSTEM=CLANG64`
```
msys2.exe   --> msys2_shell.cmd -msys  
mingw64.exe --> msys2_shell.cmd -mingw64  
mingw32.exe --> msys2_shell.cmd -mingw32
```
## toolchain
```
mingw-w64-x86_64-toolchain
```

## /clang64.ini
```
MSYS=winsymlinks:nativestrict
```

## /msys2.ini
```
#MSYS=winsymlinks:nativestrict
#MSYS=error_start:mingw64/bin/qtcreator.exe|-debug|<process-id>
#CHERE_INVOKING=1
#MSYS2_PATH_TYPE=inherit
MSYSTEM=MSYS
```

# pacman
[[pacman]]

# vim
```vim
".vimrc
set background=dark
set t_Co=256
```

# macro
```
gcc -E -dM -
```
