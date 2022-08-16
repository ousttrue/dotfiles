# The OpenXR Loader provided by Khronos
`include/openxr/openxr.h`
link `openxr_loader.lib`

- [https://www.khronos.org/files/openxr-10-reference-guide.pdf](https://www.khronos.org/files/openxr-10-reference-guide.pdf)
- [The OpenXR Specification](https://microsoft.github.io/OpenXR-MixedReality/openxr_preview/specs/openxr.html)

- [Quickstart | OpenXR Toolkit](https://mbucchia.github.io/OpenXR-Toolkit/)
- [GitHub - KhronosGroup/OpenXR-SDK: Generated headers and sources for OpenXR loader.](https://github.com/KhronosGroup/OpenXR-SDK)

`OpenXR.Loader.1.0.24.nupkg`

```
git clone https://github.com/KhronosGroup/OpenXR-SDK.git
cd OpenXR-SDK
cmake -G Ninja -Bbuild -DCMAKE_BUILD_TYPE=Release
ninja -C build install
```

runtime をロードさするには？
- [OpenXR® Loader - Design and Operation [DRAFT] (with all published extensions)](https://www.khronos.org/registry/OpenXR/specs/1.0/loader.html)
- [OpenXRランタイムを実行時に選ぶ](https://zenn.dev/shiena/articles/openxr-runtime)

# Runtime
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
	