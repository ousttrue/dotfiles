- [OpenXR - Mixed Reality | Microsoft Learn](https://learn.microsoft.com/ja-jp/windows/mixed-reality/develop/native/openxr)

- https://developers.meta.com/horizon/documentation/native/native-media-projection/
- https://github.com/android/media-samples/tree/main/ScreenCapture

- https://developers.meta.com/horizon/blog/new-era-mixed-reality-passthrough-camera-api-machine-learning-computer-vision/
- https://github.com/SuspenseExplore/audace_engine
- https://github.com/openxrlab/xrslam
- https://github.com/LRLVEC/glframework
- https://gitlab.freedesktop.org/monado/demos/openxr-simple-example

https://www.openxr-tutorial.com/

# version

## 1.1.38

# Samples

- [GitHub - jglrxavpok/Carrot: (WIP) Small game engine made for fun and educational proposes. Might do something with it later, might not.](https://github.com/jglrxavpok/Carrot)

  - [Carrot/conversions.h at 55332acf03730d133a813bd2fc572c54ff955037 · jglrxavpok/Carrot · GitHub](https://github.com/jglrxavpok/Carrot/blob/55332acf03730d133a813bd2fc572c54ff955037/engine/engine/utils/conversions.h)

- [GitHub - THolovacko/bomberman_xr: A native mixed reality Bomberman clone for the Meta Quest 2 and PC](https://github.com/THolovacko/bomberman_xr)
- [GitHub - janhsimon/openxr-vulkan-example: OpenXR & Vulkan Integration Example](https://github.com/janhsimon/openxr-vulkan-example)
- [Monado / Demos / openxr-simple-example · GitLab](https://gitlab.freedesktop.org/monado/demos/openxr-simple-example)
- [GitHub - amalon/osgXR: Virtual Reality with OpenXR and OpenSceneGraph](https://github.com/amalon/osgXR)

## MixedReality

- [OpenXR-MixedReality/samples/BasicXrApp at main · microsoft/OpenXR-MixedReality · GitHub](https://github.com/microsoft/OpenXR-MixedReality/tree/main/samples/BasicXrApp)

## vulkan

[[vulkan]]

- [GitHub - jherico/Vulkan: Examples and demos for the Vulkan C++ API](https://github.com/jherico/Vulkan)
- [GitHub - geefr/vsgvr: OpenXR integration for Vulkan Scene Graph](https://github.com/geefr/vsgvr)

## android

- [GitHub - SteakFlavored/ShockVR](https://github.com/SteakFlavored/ShockVR)
- [GitHub - kghose/hyperquest: Walk around 3D slices of high dimensional objects, "fly" in higher dimensions using hands](https://github.com/kghose/hyperquest)
- [GitHub - Wesxdz/flit_xr](https://github.com/Wesxdz/flit_xr)
- [GitHub - tkoyat/ExtendedReality: Extended Reality Browser](https://github.com/tkoyat/ExtendedReality)

## pimax

- [GitHub - mbucchia/Pimax-OpenXR: PimaxXR: an unofficial OpenXR runtime for Pimax headsets.](https://github.com/mbucchia/Pimax-OpenXR)

## クロスプラットフォーム、オプション全部入り

- [[hello_xr]]

## Windows MixedReality用

- [GitHub - microsoft/OpenXR-MixedReality: OpenXR samples and preview headers for HoloLens and Windows Mixed Reality developers familiar with Visual Studio](https://github.com/microsoft/OpenXR-MixedReality)
  シンプル
- [OpenXRSamples/SingleFileExample at master · maluoi/OpenXRSamples · GitHub](https://github.com/maluoi/OpenXRSamples/tree/master/SingleFileExample)

## ?

vulkan とか必用。ビルド失敗

- [GitHub - jherico/OpenXR-Samples: Samples for the OpenXR API](https://github.com/jherico/OpenXR-Samples)

## 未見

- [GitHub - Meumeu/WiVRn](https://github.com/Meumeu/WiVRn)

# Loader

[[openxr_loader]]
Chapter 7. [[XrSpace]]
[[hello_xr]]

- [https://www.khronos.org/files/openxr-10-reference-guide.pdf](https://www.khronos.org/files/openxr-10-reference-guide.pdf)
- [The OpenXR Specification](https://microsoft.github.io/OpenXR-MixedReality/openxr_preview/specs/openxr.html)

# システム + セッション

`OpenXR 1.0 コア仕様`

- [XrInstance](https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#instance)
- [XrSystemId](https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#system)
- [XrSession](https://www.khronos.org/registry/OpenXR/specs/1.0/html/xrspec.html#session)

# 参照スペース (ビュー、ローカル、ステージ)

- [[XrSpace]]

# Extensions

- [[openxr_api_layer]]
- [GitHub - LIV/XREW: Header Only OpenXR Extension Wrangler](https://github.com/LIV/XREW)
- [OpenXR Runtime Extension Support Report](https://github.khronos.org/OpenXR-Inventory/extension_support.html)
- [[XR_EXTX_overlay]]

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

# unity

```
XR Management has already initialized an active loader in this scene. Please make sure to stop all subsystems and deinitialize the active loader before initializing a new one.
UnityEngine.XR.Management.XRGeneralSettings:AttemptInitializeXRSDKOnLoad () (at Library/PackageCache/com.unity.xr.management@4.2.0/Runtime/XRGeneralSettings.cs:148)
```
