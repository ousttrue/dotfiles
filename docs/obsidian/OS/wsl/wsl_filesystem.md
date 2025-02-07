- [visual studio 2015 - VS15 does not recognize files cloned by git after 1803 update - Stack Overflow](https://stackoverflow.com/questions/50172869/vs15-does-not-recognize-files-cloned-by-git-after-1803-update)

wsl.conf

```
[automount]
enabled = true
options = "metadata,umask=22,fmask=11,case=off"
```

- [Windows Subsystem for Linuxのファイルシステムにおける注意点 https://qiita.com/lefb766/items/ca2be2590bd7c22395fd]
- [WSL File System Support | Microsoft Learn](https://blogs.msdn.microsoft.com/wsl/2016/06/15/wsl-file-system-support/)

# rawdisk

- [Get started mounting a Linux disk in WSL 2 | Microsoft Learn](https://learn.microsoft.com/en-us/windows/wsl/wsl2-mount-disk)

## 列挙

```sh
> GET-CimInstance -query "SELECT * from Win32_DiskDrive"

DeviceID           Caption                           Partitions Size          Model
--------           -------                           ---------- ----          -----
\\.\PHYSICALDRIVE3 Generic STORAGE DEVICE USB Device 0                        Generic STORAGE DEVICE USB Device
\\.\PHYSICALDRIVE0 ST1000DM010-2EP102                2          1000202273280 ST1000DM010-2EP102
\\.\PHYSICALDRIVE1 CT1000BX500SSD1                   1          1000202273280 CT1000BX500SSD1
\\.\PHYSICALDRIVE2 KIOXIA-EXCERIA G2 SSD             6          1000202273280 KIOXIA-EXCERIA G2 SSD

> wsl --mount \\.\PHYSICALDRIVE2 --partition 3 --bare
```


