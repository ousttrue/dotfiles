https://wiki.archlinux.jp/index.php/QEMU

- @2023 [Qemuのしくみ (の一部) - VA Linux エンジニアブログ](https://valinux.hatenablog.com/entry/20230112)
- @2019 [カーネルデバッグで使うQEMUオプションチートシート #QEMU - Qiita](https://qiita.com/wataash/items/174b454d4478898a556b)

# Version

## 8.0

- @2023 [無料仮想化ソフト「QEMU 8.0」が公開 ～Windows版のインストーラーは64bit版のみに - 窓の杜](https://forest.watch.impress.co.jp/docs/news/1498675.html)

## 7.0

- @2022 [qemu-7.0.0 のビルド](https://zenn.dev/tetsu_koba/articles/af77c1e196f1a8)

# Windows

- https://qemu.weilnetz.de/w64/

## arch iso を efi boot する

- @2018 [EFI stubなArch Linuxのインストール - Blog posts by @retrage](https://retrage01.hateblo.jp/entry/2018/10/13/002031)
- [Windows環境にUEFIアプリ動作用の仮想環境qemuをインストールする - はしくれエンジニアもどきのメモ](https://cartman0.hatenablog.com/entry/2020/12/21/Windows%E7%92%B0%E5%A2%83%E3%81%ABUEFI%E3%82%A2%E3%83%97%E3%83%AA%E5%8B%95%E4%BD%9C%E7%94%A8%E3%81%AE%E4%BB%AE%E6%83%B3%E7%92%B0%E5%A2%83qemu%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC)

```sh
qemu-system-x86_64 -m 2048 -pflash ..\OVMF.fd -hda .\arch.qcow2 -net nic,model=e1000 -net user -cdrom .\archlinux-x86_64.iso -boot d
```

# partision

- [Linux From Scratchをqemuで実行する方法](https://zenn.dev/arimax/articles/37e783f3be53a0)

```sh
qemu-img create -f qcow2 esp.qcow2 1G
```

## EFI

|         |        |                   |
| ------- | ------ | ----------------- |
| EFI ROM | raw    | OVMF.fd(readonly) |
| efivars | pflash | OVMF.fd           |
| EFI     |        |                   |
| root    | qcow2  | fs.qcow2          |
| install | cdrom  | install.iso       |

# linux kernel

- [ビルドしたLinuxカーネルをブートできる最低限の環境を用意する（with Busybox & qemu) - 豆腐の豆腐和え](http://nullpo-head.hateblo.jp/entry/2015/04/20/172059)[]()

# network

- @2018 [仮想 I/O 高速化手法まとめ - かーねるさんとか](https://yasukata.hatenablog.com/entry/2018/04/23/054418)

# vga

## virtio

[[libvirt]]

`-vga virtio`

## curses

- @2008 [QEMU/KVM curses display - KVM日記](https://kvm.hatenadiary.org/entry/20080307/1204908376)

# accelaration

## TCG

- @2020 [QEMUのTCG(Tiny Code Generator)を読み解く - FPGA開発日記](https://msyksphinz.hatenablog.com/entry/2020/08/05/040000)

## KVM

`-accel kvm`

## HAXM(Hardware Accelerated Execution Manager)

- **@2023 version 7.8 で開発終了**
- **新しいIntel CPUが必要（EPTが必須）**

[エミュレーターのパフォーマンスのためのハードウェア高速化 (Hyper-V と HAXM)](https://learn.microsoft.com/ja-jp/xamarin/android/get-started/installation/android-emulator/hardware-acceleration?pivots=windows)

- @2017 [Accelerating QEMU on Windows with HAXM - QEMU](https://www.qemu.org/2017/11/22/haxm-usage-windows/)

`-accel hax`

- @2019 [Intel HAXM と android emulator と qemu - hiroの長い冒険日記](https://hiro20180901.hatenablog.com/entry/2019/02/22/070053)
  **Install必要**

```sh
> sc query intelhaxm
[SC] EnumQueryServicesStatus:OpenService FAILED 1060:

The specified service does not exist as an installed service.
```

- [e-yuuki.org](https://e-yuuki.org/netbsd/haxm.html)
