[[Linux]]

- @2022 [Linuxカーネルビルド大全 - Qiita](https://qiita.com/progrunner/items/d2ab0a85b3881a4b7ed8)

```sh
$ git clone https://github.com/torvalds/linux.git # ソースコードを取得
$ cd linux
$ git checkout バージョン # ビルドしたいバージョンにcheckout

$ git switch -c custom
# .gitignore
# !.config

$ mkdir ../build # out-of-treeビルド（ソースコードと生成物を分離したビルド）の為のディレクトリを作成
$ make olddefconfig O=../build # 既存のコンフィグをコピー＆ビルド用ディレクトリに必要なものを生成
$ cd ../build # 以降、ソースコードの変更を伴わない場合、基本的にはビルド用ディレクトリで作業
$ make localmodconfig # 不要なモジュールを無効化
$ make menuconfig # 個別に機能の選択

$ LOCALVERSION=-mybuild make -j8 # カーネル本体＆モジュールのビルド
$ sudo make modules_install # モジュールのインストール
$ sudo make install # カーネル本体のインストール(GRUBのエントリ生成もしてくれる）

$ sudo reboot # 再起動後、必要に応じてgrubでビルドしたカーネルを選択
```

# gitignore

```
.*
!.config
```

# build env

- https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel

```sh
sudo apt install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf llvm bc
```

# make

```
Configuration targets:
  config          - Update current config utilising a line-oriented program
  nconfig         - Update current config utilising a ncurses menu based program
  menuconfig      - Update current config utilising a menu based program
  xconfig         - Update current config utilising a Qt based front-end
  gconfig         - Update current config utilising a GTK+ based front-end
  oldconfig       - Update current config utilising a provided .config as base
  localmodconfig  - Update current config disabling modules not loaded
                    except those preserved by LMC_KEEP environment variable
  localyesconfig  - Update current config converting local mods to core
                    except those preserved by LMC_KEEP environment variable
  defconfig       - New config with default from ARCH supplied defconfig
  savedefconfig   - Save current config as ./defconfig (minimal config)
  allnoconfig     - New config where all options are answered with no
  allyesconfig    - New config where all options are accepted with yes
  allmodconfig    - New config selecting modules when possible
  alldefconfig    - New config with all symbols set to default
  randconfig      - New config with random answer to all options
  yes2modconfig   - Change answers from yes to mod if possible
  mod2yesconfig   - Change answers from mod to yes if possible
  mod2noconfig    - Change answers from mod to no if possible
  listnewconfig   - List new options
  helpnewconfig   - List new options and help text
  olddefconfig    - Same as oldconfig but sets new symbols to their
                    default value without prompting
  tinyconfig      - Configure the tiniest possible kernel
  testconfig      - Run Kconfig unit tests (requires python3 and pytest)
```

## make allnoconfig

- [Linux を(わりと)シンプルな構成でビルドして Qemu で起動する](https://zenn.dev/kaishuu0123/articles/bfdeedc0492483281a4c)

```sh
$ make allnoconfig
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/menu.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
```

1400 行くらいある

## make oldconfig / make olddefconfig

## make localmodconfig

- @2021 [make localmodconfigの注意点。カーネル構築で。: ゆったりとLinux](http://fedoranize.seesaa.net/article/483732745.html)

# Gentoo

- https://wiki.gentoo.org/wiki/Kernel/Overview/ja

- [カーネル/アップグレード - Gentoo wiki](https://wiki.gentoo.org/wiki/Kernel/Upgrade/ja#.config_.E3.83.95.E3.82.A1.E3.82.A4.E3.83.AB.E3.82.92.E6.9B.B4.E6.96.B0.E3.81.99.E3.82.8B)

- https://wiki.gentoo.org/wiki/Kernel/Configuration/ja

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

# LFS

- https://www.linuxfromscratch.org/lfs/view/stable/chapter10/kernel.html
- https://www.linuxfromscratch.org/blfs/view/12.1/longindex.html#kernel-config-index

# DRM

