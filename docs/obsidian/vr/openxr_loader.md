[[OpenXR]]

- [GitHub - maluoi/openxr-explorer: A cross-platform OpenXR capabilities explorer and runtime switcher with a CLI and GUI.](https://github.com/maluoi/openxr-explorer)
`include/openxr/openxr.h`
link `openxr_loader.lib`

```cmake
# openxr_loader
add_library(openxr_loader INTERFACE)
target_include_directories(openxr_loader INTERFACE $ENV{OPENXR_SDK_DIR}/include)
target_link_directories(openxr_loader INTERFACE
                        $ENV{OPENXR_SDK_DIR}/native/x64/release/lib)
target_link_libraries(openxr_loader INTERFACE openxr_loader.lib)
```

実行時
`${env:OPENXR_SDK_DIR}/native/x64/release/bin`


# OpenXR-SDK
## source
- コード生成とサンプル
- [GitHub - KhronosGroup/OpenXR-SDK-Source: Sources for OpenXR loader, basic API layers, and example code.](https://github.com/KhronosGroup/OpenXR-SDK-Source)
- src/tests/hello_xr
- python3 が必用
	* cmake-3.18 は python-3.9 までしか検出できないことに注意

`/CMakeLists.txt` からビルドできる
=> `build/src/loader/Debug/openxr_loaderd.lib`

## generated
- [GitHub - KhronosGroup/OpenXR-SDK: Generated headers and sources for OpenXR loader.](https://github.com/KhronosGroup/OpenXR-SDK)

`OpenXR.Loader.1.0.24.nupkg`
```
git clone https://github.com/KhronosGroup/OpenXR-SDK.git
cd OpenXR-SDK
cmake -G Ninja -Bbuild -DCMAKE_BUILD_TYPE=Release
ninja -C build install
```

runtime をロードさするには？

# Android
- `arm64-v8a` and `armeabi-v7a`
- [Fixed! Please Help Me With This Build Fail for hel... - Meta Community Forums - 981069](https://forums.oculusvr.com/t5/OpenXR-Development/Fixed-Please-Help-Me-With-This-Build-Fail-for-hello-xr/td-p/981069)
