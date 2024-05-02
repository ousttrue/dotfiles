[[Linux]]
[Linuxカーネルビルド大全 - Qiita](https://qiita.com/progrunner/items/d2ab0a85b3881a4b7ed8)

# Gentoo

- https://wiki.gentoo.org/wiki/Kernel/Overview/ja

## sys-kernel/gentoo-sources

- https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Kernel#Alternative:_Manual_configuration

- https://wiki.gentoo.org/wiki/Kernel/Gentoo_Kernel_Configuration_Guide

## sys-kernel/vanilla-sources

## EFI stub

[[UKI]]

- https://wiki.gentoo.org/wiki/EFI_stub/ja

```
Processor type and features  --->
    [*] Built-in kernel command line
    (root=PARTUUID=adf55784-15d9-4ca3-bb3f-56de0b35d88d ro)
```

boot entry

```
efibootmgr --create --disk /dev/sda --label "Gentoo EFI Stub" --loader "\EFI\example\bzImage.efi" -u "root=/dev/sda3"

efibootmgr -c -d /dev/sda -p 1 -L "Gentoo EFI Stub" -l '\EFI\example\bzImage.efi' -u 'root=UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx initrd=\EFI\example\initrd.cpio.gz'
```

# .config

- https://wiki.gentoo.org/wiki/Kernel/Configuration/ja

