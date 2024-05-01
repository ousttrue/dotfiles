[[Linux]]

- [Downloads – Gentoo Linux](https://www.gentoo.org/downloads/)

# profile

## default/linux/amd64/23.0

## default/linux/amd64/17.1

# WSL

[[OS/Linux/wsl]]

- [Gentoo in WSL - Gentoo Wiki](https://wiki.gentoo.org/wiki/Gentoo_in_WSL)
- @2022 [Gentoo on WSL2](https://zenn.dev/nanasess/articles/gentoo-on-wsl2)

## 手順

get stage3 [Downloads – Gentoo Linux](https://www.gentoo.org/downloads/)

```powershell
PS> wsl --import Gentoo C:\Users\Larry\AppData\Local\WSL\Gentoo\ .\stage3-amd64-openrc-20211121T170545Z.tar --version 2
PS> wsl -d Gentoo
```

```
# emerge-websync
# eselect news read
# emerge -av vim
# vim /etc/inputrc
# vim /etc/portage/make.conf
# vim /etc/locale.gen
# locale-gen
# vim /etc/security/passwdqc.conf
# passwd
# useradd -m -G users,wheel,audio -s /bin/bash ousttrue
# passwd ousttrue
# /etc/wsl.conf
[user]
default=ousttrue
# emerge -av sudo
# visudo
# exit
```

```powershell
PS> wsl -s Gentoo
PS> wsl

wsl> default user !
wsl> sudo ls
```
