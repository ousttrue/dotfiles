LinuxFromScratch
[[Linux]]

http://www.linuxfromscratch.org/
- http://www.linuxfromscratch.org/lfs/view/stable/
- http://lfsbookja.osdn.jp/

# Version
## 11
- @2023.03

## 10
http://lfsbookja.osdn.jp/10.1-sysdja/
http://lfsbookja.osdn.jp/10.1-sysdja/prologue/package-choices.html
http://lfsbookja.osdn.jp/10.1-sysdja/chapter02/hostreqs.html
http://lfsbookja.osdn.jp/10.1-sysdja/chapter02/aboutlfs.html マウントポイント
		http://lfsbookja.osdn.jp/10.1-sysdja/partintro/toolchaintechnotes.html
		http://lfsbookja.osdn.jp/10.1-sysdja/chapter06/chapter06.html
## 8
- @2018 [Linux from Scratch-8.3に挑戦してみた - Qiita](https://qiita.com/nakamura_hikaru/items/ede8ca9d34c0c053b6aa)

## 3
- @2002 [ソースファイルからLinux環境を構築しよう！：LFSで作って学ぶLinuxの仕組み（1）（1/3 ページ） - ＠IT](https://atmarkit.itmedia.co.jp/ait/articles/0209/10/news001.html)

# 手順
- @2020 [Linux From Scratchをqemuで実行する方法](https://zenn.dev/arimax/articles/37e783f3be53a0)

## block device 作成 / mount
10GBくらい
- @2017 [【Linux】ディスクイメージをマウントする【ループバックデバイス】 - Man On a Mission](https://oplern.hatenablog.com/entry/2017/06/30/231027)
```sh
0
$ dd if=/dev/zero of=./lfs.bin bs=1G count=10
$ mkfs.ext4 lfs.bin
$ mkdir mnt
$ export LFS=`pwd`/mnt
$ export LFS_TGT="$(uname -m)-lfs-linux-gnu"
$ sudo mount -t ext4 -o loop lfs.bin $LFS
$ sudo chown user:user $LFS
```

## download sources
`$LFS/sources`
- [3.2. All Packages](https://www.linuxfromscratch.org/lfs/view/stable/chapter03/packages.html)

## toolchain 1
- [[SOLVED] LFS 7.7 GCC-4.9.2 Compile Error](https://www.linuxquestions.org/questions/linux-from-scratch-13/lfs-7-7-gcc-4-9-2-compile-error-4175543098/)
### glibc
add `--without-selinux`

# qemu
[[qemu]]
- [Linux From Scratchをqemuで実行する方法](https://zenn.dev/arimax/articles/37e783f3be53a0)
- [GitHub - fedorenchik/lfs-kvm: Build LFS 10.0 systemd/sysvinit KVM QEMU qcow2 image](https://github.com/fedorenchik/lfs-kvm)

# docker
- [GitHub - 0rland/lfs-docker: Building LFS system in docker container step by step](https://github.com/0rland/lfs-docker)

# articles
- @2020 [LFSをやってみたので振り返る - あかいものログ](https://akaimo.hatenablog.jp/entry/2020/05/11/235002)
- [Linux From Scratch · Notes](https://yangjinjie.github.io/notes/book/Linux%20From%20Scratch/)
