[muon: meson implementation in C](https://sr.ht/~lattis/muon/)

- [[meson]] の C 実装

# Windows Build

`MUON_PLATFORM_null`

`source/platform`

このあたり、Winodws版を作る必要あり
```
platform_sources = files(
    'mem.c',
    'path.c',
    # 'filesystem.c',
    # 'run_cmd.c',
    # 'term.c',
    # 'uname.c',
)
```

## unistd.h
- [c++ - Is there a replacement for unistd.h for Windows (Visual C)? - Stack Overflow](https://stackoverflow.com/questions/341817/is-there-a-replacement-for-unistd-h-for-windows-visual-c)
- [Windows unistd.h replacement · GitHub](https://gist.github.com/mbikovitsky/39224cf521bfea7eabe9)

## getopt.h
- [Visual C/C++用getoptでPOSIX的コマンドラインオプション解析 - 銀の弾丸](https://takamints.hatenablog.jp/entry/2015/04/27/231454)

## utsname.h
- [iperf-windows/utsname.h at master · tniessen/iperf-windows · GitHub](https://github.com/tniessen/iperf-windows/blob/master/win32-compat/sys/utsname.h)

## clock_gettime
- [c++ - Porting clock_gettime to windows - Stack Overflow](https://stackoverflow.com/questions/5404277/porting-clock-gettime-to-windows)
- [CLOCK_REALTIMEとCLOCK_MONOTONIC - Qiita](https://qiita.com/ozaki-r/items/fb4a48c2833e4b479ae1)
- [Windowsでclock_gettimeを使う - Retired Colourman](https://sh4869.hatenablog.com/entry/2015/01/06/161910)

## ssize_t
- [ssize_tについて - Qiita](https://qiita.com/yamori813/items/5a3b1eb33c360dfd2465)
- [`size_t`, `ssize_t`とは何か - Read -> Blog](https://codom.hatenablog.com/entry/2018/06/19/222336)
- [ssize_t ‐ 通信用語の基礎知識](https://www.wdic.org/w/TECH/ssize_t)

## S_IRUSR
- [Migrating a C program from Linux to Windows - Stack Overflow](https://stackoverflow.com/questions/20773354/migrating-a-c-program-from-linux-to-windows)

## STDIN_FILENO
- [compiler errors - STDIN_FILENO undeclared in Windows - Stack Overflow](https://stackoverflow.com/questions/13531677/stdin-fileno-undeclared-in-windows)

## pid_t
waitpid
- [C++のTips - Unix系OSでプロセスIDを取得するには？：tech.ckme.co.jp](https://tech.ckme.co.jp/cpp/cpp_pid.shtml)

## gcc: attribute
- [format属性 - Qiita](https://qiita.com/ozaki-r/items/a46197d241629fc373a7)

## dirent.h
[dirent/dirent.h at master · tronkko/dirent · GitHub](https://github.com/tronkko/dirent/blob/master/include/dirent.h)
