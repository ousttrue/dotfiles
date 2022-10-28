#red

# The OpenXR Loader provided by Khronos
`include/openxr/openxr.h`
link `openxr_loader.lib`

```cmake
# openxr
add_library(openxr INTERFACE)
target_include_directories(openxr INTERFACE $ENV{OPENXR_SDK_DIR}/include)
target_link_directories(openxr INTERFACE
                        $ENV{OPENXR_SDK_DIR}/native/x64/release/lib)
target_link_libraries(openxr INTERFACE openxr_loader.lib)
```

実行時
`${env:OPENXR_SDK_DIR}/native/x64/release/bin`

[[openxr_loader]]

- [https://www.khronos.org/files/openxr-10-reference-guide.pdf](https://www.khronos.org/files/openxr-10-reference-guide.pdf)
- [The OpenXR Specification](https://microsoft.github.io/OpenXR-MixedReality/openxr_preview/specs/openxr.html)

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


# Samples
## クロスプラットフォーム、オプション全部入り
- [[hello_xr]]

## Windows MixedReality用
- [GitHub - microsoft/OpenXR-MixedReality: OpenXR samples and preview headers for HoloLens and Windows Mixed Reality developers familiar with Visual Studio](https://github.com/microsoft/OpenXR-MixedReality)
シンプル
- [OpenXRSamples/SingleFileExample at master · maluoi/OpenXRSamples · GitHub](https://github.com/maluoi/OpenXRSamples/tree/master/SingleFileExample)

## ?
vulkan とか必用。ビルド失敗
- [GitHub - jherico/OpenXR-Samples: Samples for the OpenXR API](https://github.com/jherico/OpenXR-Samples)

# Overlay
- [GitHub - LunarG/OpenXR-OverlayLayer: Implementation of the OpenXR Overlay extension as a layer](https://github.com/LunarG/OpenXR-OverlayLayer)

# OpenXR toolkit
- [Quickstart | OpenXR Toolkit](https://mbucchia.github.io/OpenXR-Toolkit/)

# Runtime
- [OpenXR® Loader - Design and Operation [DRAFT] (with all published extensions)](https://www.khronos.org/registry/OpenXR/specs/1.0/loader.html)
- [OpenXRランタイムを実行時に選ぶ](https://zenn.dev/shiena/articles/openxr-runtime)
- [GitHub - Ybalrid/OpenXR-API-Layer-Template: A CMake based template repository to create OpenXR layers in C++](https://github.com/Ybalrid/OpenXR-API-Layer-Template)
- [device/vr/openxr/test/fake_openxr_impl_api.cc - chromium/src - Git at Google](https://chromium.googlesource.com/chromium/src/+/ae4b5702945b407b40fed05de61b52bc9ebe8451/device/vr/openxr/test/fake_openxr_impl_api.cc)
 
## [[monado]]

## [[SteamVR]]
- [Don't set location of OpenXR runtime with the registry, use OpenXR Loader Specs instead - General - Microsoft Flight Simulator Forums](https://forums.flightsimulator.com/t/dont-set-location-of-openxr-runtime-with-the-registry-use-openxr-loader-specs-instead/323323)
```
export XR_RUNTIME_JSON=/home/user/.local/share/openxr/runtime.d/steam_runtime.json
```

## Windows Mixed Reality
- [OpenXR - Mixed Reality | Microsoft Docs](https://docs.microsoft.com/en-us/windows/mixed-reality/develop/native/openxr)

- @201906 [Introduction to OpenXR - Playdeck Project](https://playdeck.net/blog/introduction-to-openxr)
	- [GitHub - maluoi/OpenXRSamples: Concise and documented examples of using OpenXR to build native Mixed Reality applications!](https://github.com/maluoi/OpenXRSamples) 

## [[godot]]
- [OpenXR plugin — Godot Engine (stable)の日本語のドキュメント](https://docs.godotengine.org/ja/stable/tutorials/vr/openxr/index.html)
- [GitHub - GodotVR/godot_openxr: OpenXR drivers for the Godot Game Engine](https://github.com/GodotVR/godot_openxr)
- [Godot Engine VR開発メモ（Quest、Steam VR、WebXR対応） - フレームシンセシス](https://framesynthesis.jp/tech/godot/vr/)
- [GitHub - CrispyPin/ovr-utils: Overlay app for OpenVR/SteamVR on Linux/Windows made in Godot](https://github.com/CrispyPin/ovr-utils)
	- [GitHub - CrispyPin/ovr-utils: Overlay app for OpenVR/SteamVR on Linux/Windows made in Godot](https://github.com/CrispyPin/ovr-utils)

## quest native	
[[QuestMobileSDK]]
