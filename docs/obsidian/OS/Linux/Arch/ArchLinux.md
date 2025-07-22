# install

```sh
$ lsblk -o name,label
$ mkfs.ext4 /dev/xxx
$ mount /dev/xxx /mnt

$ pacstrap /mnt base linux linux-firmware
$ genfstab -U /mnt >> /mnt/etc/fstab
```

## chroot, passwd, useradd

```sh
$ arch-chroot /mnt
[chroot]$ passwd
[chroot]$ useradd -m USER_NAME
[chroot]$ passwd USER_NAME
[chroot]$ usermod -aG wheel USER_NAME
[chroot]$ pacman -S vim sudo
[chroot]$ EDITOR=vim visudo
```

`/etc/inputrc` `~/.inputrc`

```sh
"\C-n":history-search-forward
"\C-p":history-search-backward
```

## bootloader

とりえあず grub2 を入れる。
grub2 のコマンドラインから起動できればなんとかなる。

```sh
$ pacman -S efibootmgr
$ efibootmgr
```

- [Unified Extensible Firmware Interface - ArchWiki](https://wiki.archlinux.jp/index.php/EFI_)%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%83%91%E3%83%BC%E3%83%86%E3%82%A3%E3%82%B7%E3%83%A7%E3%83%B3

```sh
$ pacman -S grub
$ mount /dev/ESP /efi # ESP を /efi に mount する
$ grub-install --efi-directory=/efi

# /dev/sda3 が /mnt に mount
# /mnt/boot/grub/grub.cfg に作る
# boot パーティション不用。
$ grub-mkconfig -o /boot/grub/grub.cfg
```

```
grub> set root=(hd0,gpt3) # UEFI partision
grub> linux /boot/vmlinuz root=/dev/sda3 # kernel
grub> initrd /boot/initrd.img # initrd
grub> boot
```

## dhcpcd

```sh
$ pacman -S dhcpcd
# $ systemctl start dhcpcd@enp3s0.service
$ systemctl enable --now dhcpcd@enp3s0.service
```

## openssh

```sh
$ pacman -S openssh
# $ systemctl start sshd.service
$ systemctl enable --now sshd.service
```

## reboot

```
# dhcpcd enp3s0
```

## neovim build

```sh
$ sudo pacman -S base-devel cmake ninja curl
```

# wayland

```
$ sudo pacman -S seatd nvidia labwd
$ systemctl enable seatd.service --now
# GRUP seat 追加
```

`/etc/modprobe.d/nvidia.conf`

```sh
options nvidia_drm modeset=1
```

## DisplayManager

- ly

## X

# pacman

mirror

https://archlinux.org/mirrorlist/

`/etc/pacman.d/mirrorlist`

```sh
pacman sudo
```

## AUR

- [Arch User Repository - ArchWiki](https://wiki.archlinux.jp/index.php/Arch_User_Repository)
- [Arch Linux : AURヘルパー「yay」を試す | SlackNote](https://slacknotebook.com/testing-out-arch-linux-aur-helper-yay/)
- [Arch Linux : AURヘルパー「paru」を導入する | SlackNote](https://slacknotebook.com/arch-linux-aur-helper-paru/)

# app

```sh
$ sudo pacman -S tmux git dotnet-sdk-8.0
```
