https://www.spice-space.org/index.html

- @2022 [リモートのLXDインスタンスの画面をローカルから操作してVDI環境を構築する](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0738)
- @2010 [次世代デスクトップ転送技術、SPICE入門：Inside Linux KVM（1）（2/2 ページ） - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/1006/29/news083_2.html)

# QXL

> グラフィックデバイスとしてQXLを指定した仮想マシン
> depends on libvirt

ぽい？

## WSL

**WSLから qemu-system-x86_64 -vga qxl** で使える。 `spice://localhost:5930`

- [Install virt-manager in Windows 11 WSL (qemu, Windows Subsystem for Linux) · GitHub](https://gist.github.com/klo2k/fe794f107c11292ba47b4d052c547983)

**arch install**

```sh
qemu-system-x86_64 -accel kvm -cpu host -vga qxl -m 8G -smp 4 -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/OVMF.fd -pflash OVMF.fd -drive file=arch.qcow2,if=virtio -net nic,model=virtio -net user -cdrom /mnt/d/iso/archlinux-x86_64.iso -boot once=d -no-reboot -hda fat:rw:./efi
```

# client

- @2019 [リモートデスクトップのためのSPICEクライアントあれこれ](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0595)

## vert-viewer

## spice-gtk

https://gitlab.freedesktop.org/spice/spice-gtk

# docker

- @2016 [Docker + KVM 上で Xubuntu を動かす #Docker - Qiita](https://qiita.com/nikola-f/items/ba1ac612d6bea11387ad)
