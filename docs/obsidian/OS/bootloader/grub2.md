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

## saved

```sh
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```

## windows

https://unix.stackexchange.com/questions/432176/how-to-add-windows-10-to-grub-on-arch-install-with-efi

```sh
GRUB_DISABLE_OS_PROBER=false

Get the UUID with: sudo grub-probe -t fs_uuid -d /dev/sda1

and then add an entry for Windows at the end of your grub.cfg:

menuentry "Windows 10" {
insmod part_gpt
insmod fat
insmod search_fs_uuid
insmod chain
search --fs-uuid --no-floppy --set=root XXXXXXXXX
chainloader (${root})/efi/Microsoft/Boot/bootmgfw.efi
}
```

