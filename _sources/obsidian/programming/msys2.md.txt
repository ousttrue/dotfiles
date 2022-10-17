[MSYS2](https://www.msys2.org/)

- @2021 [Windows 10 Pro で MSYS2 を出来る限り高速化する](https://zenn.dev/nyarla/articles/489394cec0ecb5)
- [MSYS2で快適なターミナル生活 - Qiita](https://qiita.com/Ted-HM/items/4f2feb9fdacb6c72083c)
- [Python x64 & MinGW64 環境の構築 | Wizard in the Market](https://fx-kirin.com/python/windows-python-mingw64-environment-build/)
- [CmderでMSYS2の環境を構築してみる - zyzyz's Playground](https://zyzyz.github.io/ja/2017/10/Integrate-MSYS2-into-Cmder/)

# fstab
```
# /etc/fstab
# DO NOT REMOVE NEXT LINE. It remove cygdrive prefix from path
none / cygdrive binary,posix=0,noacl,user 0 0

C:/Users /home
```

# symlink

- [Windows 10 Pro で MSYS2 を出来る限り高速化する](https://zenn.dev/nyarla/articles/489394cec0ecb5#3.-msys2-%E7%92%B0%E5%A2%83%E3%81%A7-ntfs-%E3%81%AE-symlink-%E3%81%8C%E4%BD%BF%E3%81%88%E3%82%8B%E6%A7%98%E3%81%AB%E3%81%99%E3%82%8B)

`clang64.ini`
```
MSYS=winsymlinks:nativestrict
```

# $MSYSTEM
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

# /msys2.ini

```
#MSYS=winsymlinks:nativestrict
#MSYS=error_start:mingw64/bin/qtcreator.exe|-debug|<process-id>
#CHERE_INVOKING=1
#MSYS2_PATH_TYPE=inherit
MSYSTEM=MSYS
```

# pacman

```
$ pacman --needed -Sy bash pacman pacman-mirrors msys2-runtime
```

```
$ pacman -Syu
-S sync
-y update
-u upgrade
```

# clang
- [Msys2のclangを9.0から12.0に更新する | うどんコード](https://udon.little-pear.net/msys2-clang-update-from9-to12/)

# vim
```vim
".vimrc
set background=dark
set t_Co=256
```
