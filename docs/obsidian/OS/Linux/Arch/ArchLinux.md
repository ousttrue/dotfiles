# Install

```sh
$ lsblk -o name,label
$ mkfs.ext4 /dev/xxx
$ mount /dev/xxx /mn

$ pacstrap /mnt base linux linux-firmware
$ genfstab -U /mnt >> /mnt/etc/fstab
```

## chroot

```sh
$ pacman -S vim dhcpcd
```

- passwd
- boot loader [[boot]]
- user

```
# useradd -m USER_NAME
# passwd USER_NAME
```

## bootloader

とりえあず grub2 を入れる。
grub2 のコマンドラインから起動できればなんとかなる。

```
# pacman -S grub efibootmgr
# grub-install --efi-directory=/boot
# grub-mkconfig -o /boot/grub/grub.cfg
```

```
grub> set root=(hd0,0) # UEFI partision
grub> linux /vmlinuz root=/dev/nvme0n1p2 # kernel
grub> initrd /initrd.img # initrd
grub> boot
```

## dhcpcd

```
# pacman -S dhcpcd
# systemctl start dhcpcd@enp3s0.service
# systemctl enable dhcpcd@enp3s0.service
```

## openssh

```
pacman -S openssh
systemctl start sshd.service
systemctl enable sshd.service
```

## reboot

```
# dhcpcd enp3s0
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
