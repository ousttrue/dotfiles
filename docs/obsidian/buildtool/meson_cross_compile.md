[[meson]]

# tool chain の置き換え
- [Cross and Native File reference](https://mesonbuild.com/Machine-files.html)

```
meson setup builddir --cross-file mingw_x86_64.ini
# or
meson setup builddir --native-file clang.ini
```

## cross-file
- [Cross compilation](https://mesonbuild.com/Cross-compilation.html)

## native-file
`host_machine` セクションが無い場合？
- [Persistent native environments](https://mesonbuild.com/Native-environments.html) 

# examples
## msys2

`muon` のビルドとか
```ini
[binaries]
c          = 'x86_64-pc-msys-gcc'
cpp        = 'x86_64-pc-msys-g++'
ar         = 'x86_64-pc-msys-gcc-ar'

[host_machine]
system     = 'linux'
cpu_family = 'x86_64'
cpu        = 'x86_64'
endian     = 'little'
```

`MSYS64/usr/bin` に path を通して `meson` を実行するべし。
```json
            "options": {
                "env": {
                    "PATH": "${env:PATH};C:\\Python310\\Scripts;D:\\msys64\\usr\\bin",
                },
                "shell": {
                    "executable": "${env:ComSpec}",
                    "args": [
                        "/d",
                        "/c"
                    ]
                }
            }
```

## zig
配列使える
```ini
[binaries]
c = ['zig', 'cc']
cpp = ['zig', 'c++']
ar = ['zig', 'ar']
dlltool = ['zig', 'dlltool']
lib = ['zig', 'lib']
ranlib = ['zig', 'ranlib']
```

 ## clang-ucrt on Linux
```ini
 [binaries]
c = '/mnt/d/llvm-mingw-20230130-ucrt-x86_64/bin/x86_64-w64-mingw32-clang.exe'
cpp = '/mnt/d/llvm-mingw-20230130-ucrt-x86_64/bin/x86_64-w64-mingw32-clang++.exe'
ar = '/mnt/d/llvm-mingw-20230130-ucrt-x86_64/bin/x86_64-w64-mingw32-llvm-ar.exe'
strip = '/mnt/d/llvm-mingw-20230130-ucrt-x86_64/bin/x86_64-w64-mingw32-strip.exe'
windres = '/mnt/d/llvm-mingw-20230130-ucrt-x86_64/bin/x86_64-w64-mingw32-windres.exe'
exe_wrapper = 'wine64'

[host_machine]
system = 'windows'
cpu_family = 'x86_64'
cpu = 'x86_64'
endian = 'little'
```
