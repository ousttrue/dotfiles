[[spir-v]] [[ktx2]] [[VkInstance]] [[VkSwapchainKHR]] [[VkPipeLine]] [[VkCommandList]]

- [LunarXchange](https://vulkan.lunarg.com/)

- @2019 [Vulkanの道も一歩から【カウントダウンカレンダー2019冬13日目】 - MIS.W 公式ブログ](https://blog.misw.jp/entry/2019/12/24/000000)

# Version
## 1.3
- @2022 [Vulkan 1.3がリリース。新追加機能はオプションではなく実装を義務付け - PC Watch](https://pc.watch.impress.co.jp/docs/news/1383547.html)

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

## android
- [GitHub - IkeikeP/vulkan-hpp-triangle-android: A vulkan-hpp implementation of the popular triangle.](https://github.com/IkeikeP/vulkan-hpp-triangle-android)

# samples
- [GitHub - KhronosGroup/Vulkan-Samples: One stop solution for all Vulkan samples](https://github.com/KhronosGroup/Vulkan-Samples)
- [GitHub - SaschaWillems/Vulkan: Examples and demos for the new Vulkan API](https://github.com/SaschaWillems/Vulkan)

# tutorial
- [Vulkan-Guide/README-jp.adoc at master · KhronosGroup/Vulkan-Guide · GitHub](https://github.com/KhronosGroup/Vulkan-Guide/blob/master/lang/jp/README-jp.adoc)
- @2022 [Vulkan入門で参考になる資料](https://zenn.dev/nishiki/articles/6237fcd3177def)
- [Site Unreachable](https://vulkan-tutorial.com/)

# GLFW
- [GLFW: Vulkan guide](https://www.glfw.org/docs/3.3/vulkan_guide.html)

# Gentoo
[[Gentoo]]
- @2021 [Gaming on Gentoo Linux - joker1007’s diary](https://joker1007.hatenablog.com/entry/2021/04/10/223111)
- [GitHub - SaschaWillems/Vulkan: Examples and demos for the new Vulkan API](https://github.com/SaschaWillems/Vulkan)

# direct display
- [VulkanダイレクトディスプレイにレンダリングするOpenGLサンプル - wenyanet](https://www.wenyanet.com/opensource/ja/60d63a296dc47e20d012d9ed.html)
[[VK_KHR_display]]

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
