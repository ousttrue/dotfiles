- [Classic SysAdmin: How to Rescue a Non-booting GRUB 2 on Linux - Linux Foundation](https://www.linuxfoundation.org/blog/blog/classic-sysadmin-how-to-rescue-a-non-booting-grub-2-on-linux)

# update-grub

- [grub(2)-mkconfig(update-grub)の振る舞いの違い、各ディストロでの。: ゆったりとLinux](http://fedoranize.seesaa.net/article/483266532.html)

- [Ubuntuの標準ブートローダーであるGRUBを改めて見直す](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0743)
- [update-grubの仕組みを使ってUbuntuのGRUBをさらにカスタマイズする](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0746)

- [Ubuntuの起動メニュー（GNU　GRUB）を整理する方法 - 青ペンのIT事情](https://blog.goo.ne.jp/aopen000/e/c8746e4fa0dc065c90afb50be27bc07a)

- /etc/default/grub

```sh
GRUB_DEFAULT="saved"
GRUB_SAVEDEFAULT="true"
#GRUB_DISABLE_OS_PROBER=false
```

- /etc/grub.d/

👇

`update-grub(grub-mkconfig)`

👇

- /boot/grub/grub.cfg

## /etc/grub.d/30_os-prober

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
