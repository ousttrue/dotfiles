[[nvidia]]

- linux-headers
無いと次でエラー。
`==> ERROR: Missing run kernel headers for module nvidia/545.29.02.`

# nvidia-dkms 
(ビルド。時間かかる)
[Dynamic Kernel Module Support - ArchWiki](https://wiki.archlinux.jp/index.php/Dynamic_Kernel_Module_Support#.E3.82.A4.E3.83.B3.E3.82.B9.E3.83.88.E3.83.BC.E3.83.AB)

# nvidia-vulkan-dkms
- `AUR` nvidia-vulkan-dkms

# boot option

```
nvidia_drm.modeset=1"
```

## mkinitcpio
`/etc/mkinitcpio.conf`
```
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```

https://wiki.archlinux.org/title/mkinitcpio
```
# mkinitcpio -p linux
```
