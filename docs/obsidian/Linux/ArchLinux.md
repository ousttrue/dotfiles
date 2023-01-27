[[pacman]]

- [Arch Linux JP Project](https://www.archlinux.jp/)

# Install
	pacstrap /mnt base linux linux-firmware
	genfstab -U /mnt >> /mnt/etc/fstab
	
* passwd
* boot loader
- network
	- dhcp
		- /etc/systemd/network/conf
```
systemctl enable systemd-networkd.service`
systemctl start systemd-networkd.service`
systemctl enable systemd-resolved.service`
systemctl start systemd-resolved.service`
ln -sf /run/systemd/resolve/resolv.conf /etc/resolve.conf`
```
- user
- ssh
```
systemctl enable sshd.service
systemctl start sshd.service
```

- sudo

## pacman
[[pacman]]

# AUR
- [Arch User Repository - ArchWiki](https://wiki.archlinux.jp/index.php/Arch_User_Repository)
- [Arch Linux : AURヘルパー「yay」を試す | SlackNote](https://slacknotebook.com/testing-out-arch-linux-aur-helper-yay/)
- [Arch Linux : AURヘルパー「paru」を導入する | SlackNote](https://slacknotebook.com/arch-linux-aur-helper-paru/)

# DisplayManager
- ly

# X
