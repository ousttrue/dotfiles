wsl filesystem
[[wsl]]

	https://stackoverflow.com/questions/50172869/vs15-does-not-recognize-files-cloned-by-git-after-1803-update
	[RS4のWindows Subsystem for Linuxでのwsl.confによる初期設定 http://ascii.jp/elem/000/001/634/1634120/]

code:wsl.conf
 [automount]
 enabled = true
 options = "metadata,umask=22,fmask=11,case=off"

	[Windows Subsystem for Linuxのファイルシステムにおける注意点 https://qiita.com/lefb766/items/ca2be2590bd7c22395fd]
	https://blogs.msdn.microsoft.com/wsl/2016/06/15/wsl-file-system-support/

[* VolFs]
/

`%LocalAppData%\lxss`

[* DrvFs]
/mnt/c

[* lsの色]
https://www.kwbtblog.com/entry/2019/04/27/023411

mount

# rawdisk
- [Get started mounting a Linux disk in WSL 2 | Microsoft Learn](https://learn.microsoft.com/en-us/windows/wsl/wsl2-mount-disk)

## 列挙

```
GET-CimInstance -query "SELECT * from Win32_DiskDrive"
```

