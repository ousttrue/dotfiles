- [Classic SysAdmin: How to Rescue a Non-booting GRUB 2 on Linux - Linux Foundation](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-how-to-rescue-a-non-booting-grub-2-on-linux)

# command boot
```
grub> set root=(hd0,0) # UEFI partision
grub> linux /vmlinuz root=/dev/sda2 # kernel
grub> initrd /initrd.img # initrd
grub> boot
```

root 無しだと下記
```
grub> linux (hd0,0)/vmlinuz root=/dev/sda2 # kernel
grub> initrd (hd0,0)/initrd.img # initrd
grub> boot
```
