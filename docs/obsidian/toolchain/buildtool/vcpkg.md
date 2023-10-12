vcpkg
	https://vcpkg.readthedocs.io/en/latest/

# triplets

```
vcpkg help triplets
```

```
 > .\vcpkg.exe help triplet
 Available architecture triplets:
   arm-uwp
   arm-windows
   arm64-uwp
   arm64-windows
   x64-linux
   x64-osx
   x64-uwp
   x64-windows <- これ
   x64-windows-static
   x86-uwp
   x86-windows
   x86-windows-static
```

zig用
`$ vcpkg install llvm[clang]:x64-windows-static`

## 環境変数
`VCPKG_DEFAULT_TRIPLET=x64-windows`

# 先に入れる方がよいパッケージ(依存)]
	VTK
	
# select vc
https://github.com/microsoft/vcpkg/blob/master/docs/users/triplets.md#vcpkg_platform_toolset
	The Visual Studio 2019 platform toolset is v142.
	The Visual Studio 2017 platform toolset is v141.
	The Visual Studio 2015 platform toolset is v140.

# CMAKE_TOOLCHAIN_FILE
integration してないとき 

```settings.json
"cmake.configureArgs": [
 "-DCMAKE_PREFIX_PATH=${env:VCPKG_DIR}/installed/x64-windows"
]    
```

integration しているとき?

https://github.com/microsoft/vcpkg/blob/master/docs/users/integration.md

```
$ cmake ../my/project -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake
```

vscode
	`cmake.configureSettings` ?



[* from github]
> .\vcpkg.exe create libtermkey https://github.com/neovim/libtermkey.git
	https://vcpkg.readthedocs.io/en/latest/maintainers/vcpkg_from_github/

[* overlay]
https://github.com/microsoft/vcpkg/blob/master/docs/specifications/ports-overlay.md

# openssl:x64-windows-static
```
Elapsed time to handle openssl:x64-windows-static: 3.7 min
Total install time: 3.7 min
The package openssl is compatible with built-in CMake targets:

    find_package(OpenSSL REQUIRED)
    target_link_libraries(main PRIVATE OpenSSL::SSL OpenSSL::Crypto)
	
```
