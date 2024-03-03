[[boot]]
[[GPT]]

- https://github.com/tsuyopon/memo/blob/master/UEFI/UEFI.md

- [GRUB と EFI の組み合わせで使うときのメモ または EFI 全般の tips](https://orumin.blogspot.com/2013/01/grubefi.html)
- [小手先でつくる自作 OS – UEFI boot から kernel ロードまで | ふぁろぐねっと](https://falog.net/kotesaki-os001/)
- [ブートローダーは 4 行で実装される](https://orumin.blogspot.com/2014/12/4.html)
- [フルスクラッチで作る!UEFI ベアメタルプログラミング](http://yuma.ohgami.jp/UEFI-Bare-Metal-Programming/index.html)
- [yuma.ohgami.jp/ubmp/UEFI-Bare-Metal-Programming_20170811.pdf](http://yuma.ohgami.jp/ubmp/UEFI-Bare-Metal-Programming_20170811.pdf)
- [Rust で UEFI アプリケーションを書く 2020 Edition - 重力に縋るな](https://sksat.hatenablog.com/entry/2020/12/21/212651)
- [UEFI エミュレータで遊ぶ](https://zenn.dev/nokute/articles/7b085ad55e174a)
- [現代における自作 OS の難しさ 〜自作 OS のいまと昔 [第 2 回] | さくらのナレッジ](https://knowledge.sakura.ad.jp/22963/)

## partition 構成

> ストレージの第一パーティションを UEFI のシステムパーティション
> FAT32
> 512MB くらい？

```
/dev/sda1       511M  4.0K  511M   1% /boot/efi
```

| partition | size                           |
| --------- | ------------------------------ |
| EFI       | 512MB                          |
| SWAP      | MEMORY x 2 (for example: 32GB) |
| /         | 200GB                          |

## efi variable(NVRAM: Non Volatile Random Acess Memory)

- GetVariables
- GetNextVariablesName
- SetVariables
- QueryVairableInfo

`/sys/firmware/efi/efivars`

- @2022 [UEFI対応BIOSとSecureBootの訓練をしてみる話 | スクエニ ITエンジニア ブログ](https://blog.jp.square-enix.com/iteng-blog/posts/00021-uefi-bios-secureboot-practice/)
- `efivars` @2018 [LinuxにおけるEFI Variableをみてみる - Blog posts by @retrage](https://retrage01.hateblo.jp/entry/2018/12/20/100949)

```sh
efivar -l
```

## secure-boot

- @2016 [QEMU/KVMでセキュアブートを利用する](https://gihyo.jp/admin/serial/01/ubuntu-recipe/0446)

# UEFI ブートマネージャー

## efibootmgr

## Application

[UEFI アプリケーションの書き方/Hello World プログラム - Wikibooks](https://ja.wikibooks.org/wiki/UEFI%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E6%9B%B8%E3%81%8D%E6%96%B9/Hello_World%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0)

## Limine

- https://limine-bootloader.org/

`esp/EFI/BOOT/BOOTX64.EFI`


# dev

## gnu-efi

- [gnu-efi で UEFI 遊びをはじめよう - Qiita](https://qiita.com/tnishinaga/items/40755f414557faf45dcb)

## EDK2

- [EDK II で UEFI アプリケーションを作る — osdev-jp core docs 1.0 ドキュメント](https://osdev-jp.readthedocs.io/ja/latest/2017/create-uefi-app-with-edk2.html)

# QEMU

- @2022 [Linux のマルチブートを作りたい レベル３ EFIブートのGRUBでマルチブートする - それマグで！](https://takuya-1st.hatenablog.jp/entry/2022/12/28/155113)
