[[meson]]

- [Cross and Native File reference](https://mesonbuild.com/Machine-files.html)

# cross
- [Cross compilation](https://mesonbuild.com/Cross-compilation.html)

## msys
`--cross-file msys.txt`
```
[host_machine]
system     = 'linux'
cpu_family = 'x86_64'
cpu        = 'x86_64'
endian     = 'little'

[binaries]
c          = 'x86_64-pc-msys-gcc'
cpp        = 'x86_64-pc-msys-g++'
ar         = 'x86_64-pc-msys-gcc-ar'
```

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

# native
- [Persistent native environments](https://mesonbuild.com/Native-environments.html) 
 