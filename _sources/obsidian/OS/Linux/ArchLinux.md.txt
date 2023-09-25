[[pacman]]

- [Arch Linux JP Project](https://www.archlinux.jp/)

# Install
	pacstrap /mnt base linux linux-firmware
	genfstab -U /mnt >> /mnt/etc/fstab

## chroot
```
# pacman -S vim dhcpcd
```
 
* passwd
* boot loader [[boot]]

- user
```
# useradd -m USER_NAME
# passwd USER_NAME
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

## pacman
[[pacman]]

# AUR
- [Arch User Repository - ArchWiki](https://wiki.archlinux.jp/index.php/Arch_User_Repository)
- [Arch Linux : AURヘルパー「yay」を試す | SlackNote](https://slacknotebook.com/testing-out-arch-linux-aur-helper-yay/)
- [Arch Linux : AURヘルパー「paru」を導入する | SlackNote](https://slacknotebook.com/arch-linux-aur-helper-paru/)

# DisplayManager
- ly

# X
