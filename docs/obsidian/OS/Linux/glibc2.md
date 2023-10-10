---
aliases:
  - libc6
---
[Linux C Library (libc) について](https://linuxjf.osdn.jp/JFdocs/libc-intro.html)

[[libc]]

- @2022 [Rust でバイナリを配布する](https://zenn.dev/coord_e/articles/portable-binary-in-rust)

`libc.so.6`

# Version
- [Glibc Timeline - glibc wiki](https://sourceware.org/glibc/wiki/Glibc%20Timeline)
- [glibc ‐ 通信用語の基礎知識](https://www.wdic.org/w/TECH/glibc)
- [glibc/バージョン - おなかすいたWiki！](https://wiki.onakasuita.org/pukiwiki/?glibc%2F%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3)

## 2.35
- [[Ubuntu]] `22.04`
## 2.34
- [[zig]] `0.11`
```
error: zig does not yet provide glibc version 2.35, the max provided version is 2.34
error: unable to build glibc shared objects: InvalidTargetGLibCVersion
```
## 2.31
Debian 11 Bullseye

## 2.28
Debian 10 Buster

## 2.26
amazonlinux:2.0.20200406.0

## 2.17
`x86_64-linux-gnu.2.17`
- @2020 [glibc のバージョンアップでアプリケーションが動かなくなった件 - Qiita](https://qiita.com/matsumoto_sp/items/fc3d4d698bba4eb7b534)
[[CentOS]] 7
- @2019 [コンテナでC言語の開発環境を構築する - Qiita](https://qiita.com/Be-cricket/items/0d6da899045a1cbab3ea#dockerfile)

[[Rust]] 1.64~
- @2022 [Increasing the glibc and Linux kernel requirements | Rust Blog](https://blog.rust-lang.org/2022/08/01/Increasing-glibc-kernel-requirements.html)

- @2013 [Arch Linux - News: Update filesystem-2013.01-1 and glibc-2.17-2 together](https://archlinux.org/news/update-filesystem-201301-1-and-glibc-217-2-together/)

### zig
- [`zig cc`: a Powerful Drop-In Replacement for GCC/Clang - Andrew Kelley](https://andrewkelley.me/post/zig-cc-powerful-drop-in-replacement-gcc-clang.html)
- [use RHEL 7 / CentOs 7 as the baseline glibc version rather than oldest Debian under LTS · Issue #10840 · ziglang/zig · GitHub](https://github.com/ziglang/zig/issues/10840) 

# 別バージョンの build

- [それ行けLinux～Glibc2環境の構築～](http://ryouto.jp/linux/linux_58.html)
