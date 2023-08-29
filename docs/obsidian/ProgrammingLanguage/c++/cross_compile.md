- [[MinGW-w64]]

- @2010 [configureのbuild、host、targetの違い - maminusのメモか何か](https://maminus.hatenadiary.org/entry/20100129/1264781242)

# args
## target
## host
## build
crosstool の target

# ArchLinux
[[ArchLinux]]
- mingw-w64-binutils
- mingw-w64-crt
- mingw-w64-headers
- mingw-w64-winpthreads
- mingw-w64-gcc
[[meson]]
- [Cross compilation](https://mesonbuild.com/Cross-compilation.html)

```meson.ini
[binaries]
c = 'x86_64-w64-mingw32-gcc'
cpp = 'x86_64-w64-mingw32-g++'
ar = 'x86_64-w64-mingw32-ar'
strip = 'x86_64-w64-mingw32-strip'
windres = 'x86_64-w64-mingw32-windres'
exe_wrapper = 'wine64'

[host_machine]
system = 'windows'
cpu_family = 'x86_64'
cpu = 'x86_64'
endian = 'little'
```
