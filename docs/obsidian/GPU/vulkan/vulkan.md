[[spir-v]] [[ktx2]] [[VkInstance]] [[VkSwapchainKHR]] [[VkPipeLine]] [[VkCommandList]]

- https://github.com/silbinarywolf/zig-android-sdk/blob/main/examples/sdl2/android/src/ZigSDLActivity.java
- https://github.com/ARM-software/vulkan-sdk/tree/master/samples/hellotriangle
- https://github.com/nvpro-samples/vk_minimal_latest

- [LunarXchange](https://vulkan.lunarg.com/)

- @2019 [Vulkanの道も一歩から【カウントダウンカレンダー2019冬13日目】 - MIS.W 公式ブログ](https://blog.misw.jp/entry/2019/12/24/000000)

# Version

## 1.3

- @2022 [Vulkan 1.3がリリース。新追加機能はオプションではなく実装を義務付け - PC Watch](https://pc.watch.impress.co.jp/docs/news/1383547.html)

## 1.2

- @2020 [GPUの進化に合わせて改良が続けられる3DグラフィックスAPI　「Vulkan1.2」における機能の追加と拡張 - ログミーTech](https://logmi.jp/tech/articles/326296)

## 1.1

- @2018 [グラフィックスAPI「Vulkan」バージョン1.1公開 - PC Watch](https://pc.watch.impress.co.jp/docs/news/1110461.html)
- @2018 [グラフィックスAPI「Vulkan」がmacOS/iOSで利用可能に - PC Watch](https://pc.watch.impress.co.jp/docs/news/1108626.html)

## 1.0

- @2016 [クロノス・グループ、Vulkan 1.0を発表 - Press Release - Khronos Group](https://jp.khronos.org/news/press/vulkan-1.0)

## deprecated

`VK_DYNAMIC_STATE_RANGE_SIZE`

# cmake

`%VULKAN_SDK% = D:\VulkanSDK\1.3.236.0`

```CMakeLists.txt
find_package(Vulkan)
```

# vulkan.hpp

- [GitHub - KhronosGroup/Vulkan-Hpp: Open-Source Vulkan C++ API](https://github.com/KhronosGroup/Vulkan-Hpp)

## sample

- [Vulkan_Test/01_triangle.cpp at master · SaschaWillems/Vulkan_Test · GitHub](https://github.com/SaschaWillems/Vulkan_Test/blob/master/01_triangle/01_triangle.cpp)

# samples

- [GitHub - KhronosGroup/Vulkan-Samples: One stop solution for all Vulkan samples](https://github.com/KhronosGroup/Vulkan-Samples)
- [GitHub - SaschaWillems/Vulkan: Examples and demos for the new Vulkan API](https://github.com/SaschaWillems/Vulkan)

# tutorial

- [Vulkan-Guide/README-jp.adoc at master · KhronosGroup/Vulkan-Guide · GitHub](https://github.com/KhronosGroup/Vulkan-Guide/blob/master/lang/jp/README-jp.adoc)
- @2022 [Vulkan入門で参考になる資料](https://zenn.dev/nishiki/articles/6237fcd3177def)
- [Site Unreachable](https://vulkan-tutorial.com/)

# GLFW

- [GLFW: Vulkan guide](https://www.glfw.org/docs/3.3/vulkan_guide.html)

# Linux

## Gentoo

[[gentoo]]

- @2021 [Gaming on Gentoo Linux - joker1007’s diary](https://joker1007.hatenablog.com/entry/2021/04/10/223111)
- [GitHub - SaschaWillems/Vulkan: Examples and demos for the new Vulkan API](https://github.com/SaschaWillems/Vulkan)

## Ubuntu

- @2016 [Ubuntu 16.04 で Vulkan を使う – すらりん日記](https://blog.techlab-xe.net/post-4506/)

## ArchLinux

- [Vulkan - ArchWiki](https://wiki.archlinux.jp/index.php/Vulkan)

# direct display

- [VulkanダイレクトディスプレイにレンダリングするOpenGLサンプル - wenyanet](https://www.wenyanet.com/opensource/ja/60d63a296dc47e20d012d9ed.html)
  [[VK_KHR_display]]
- [「Linuxでアプリから直接画面を表示したい」　インスタンス拡張「VK_KHR_display」を使った、画面占有方法 - ログミーTech](https://logmi.jp/tech/articles/328183)

# Android

[[Android]]

- [Vulkan の実装  |  Android オープンソース プロジェクト  |  Android Open Source Project](https://source.android.com/docs/core/graphics/implement-vulkan?hl=ja)

# error

## Failed to open JSON file

```
validation layer: loader_get_json: Failed to open JSON file C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayVkLayer-Win32.json
validation layer: loader_get_json: Failed to open JSON file C:\Program Files (x86)\Epic Games\Launcher\Portal\Extras\Overlay\EOSOverlayVkLayer-Win64.json
```

[Vulkan: Spurious "Failed to open JSON file" printed due to invalid Vulkan ICD files · Issue #56089 · godotengine/godot · GitHub](https://github.com/godotengine/godot/issues/56089)

# app

- [GitHub - liblava/liblava: Modern and easy-to-use library for Vulkan](https://github.com/liblava/liblava)
