---
aliases: [VRPT]
---

[[OpenXR]]


# MVR
`MultiView` => `MVR`
OpenGL はこっち？
- [OpenGL ES SDK for Android: Using multiview rendering](https://arm-software.github.io/opengl-es-sdk-for-android/multiview.html)

# VPRT
`Instanced Stereo` => `VRPT`
- @2022 [Unity VR での Shader について - memomem](https://inoookov.hatenablog.com/entry/2022/03/31/150520)
`MRT Multi Render Target` の応用。
RenderTarget 毎に別の Viewport を用いる？
- [VPRT Support (as opposed to MRT) · Issue #2320 · bkaradzic/bgfx · GitHub](https://github.com/bkaradzic/bgfx/issues/2320)

```cpp
XrSwapchainCreateInfo
{
	.arraySIze = 2,
};

// 👇

XrCompositionLayerProjection
{
    .viewCount = 2,
    .views = {
		{
		  .subImage = {
			.imageArrayIndex = 0,
		  },
		},
		{
		  .subImage = {
			.imageArrayIndex = 1,
		  },
		},    
	},
};
```

## unity
`single pass`
- [Unity - Manual: Single Pass Instanced rendering](https://docs.unity3d.com/Manual/SinglePassInstancing.html)

- @2019 [そのシェーダー、本当にVR対応できてますか？　～Pimax、広視野角ヘッドセットへの対応～ - Qiita](https://qiita.com/RamType0/items/baf2b9d5ce0f9fc458be)
- @2018 [Unity の XR 向けシングルパスステレオレンダリングについて調べてみた - 凹みTips](https://tips.hecomi.com/entry/2018/11/04/232219)
	
## d3d11
`DrawIndexedInstanced`
- @2017 [HololensでMMDモデルをレンダリングしてみる[c++/UWP] - catalinaの備忘録](https://catalina1344.hatenablog.jp/entry/2017/02/08/223357)

## OpenGL
-   `GL_NV_viewport_array2`
-   `GL_AMD_vertex_shader_layer`
-   `GL_ARB_shader_viewport_layer_array`

`gl_ViewportIndex`
- [https://registry.khronos.org/OpenGL/extensions/ARB/ARB_shader_viewport_layer_array.txt](https://registry.khronos.org/OpenGL/extensions/ARB/ARB_shader_viewport_layer_array.txt)

#    Render with texture array and VPRT
> [OpenXR best practices - Mixed Reality | Microsoft Learn](https://learn.microsoft.com/en-us/windows/mixed-reality/develop/native/openxr-best-practices)

instancing で１回のドローコールで描画するべし。
Color と Depth の swapchain で２つ作るべし。
Depth は hololens 向け？

Create one `xrSwapchain` for both left and right eye using `arraySize=2` for color swapchain, and one for depth. Render the left eye into slice 0 and the right eye into slice 1. Use a shader with VPRT and instanced draw calls for stereoscopic rendering to minimize GPU load. This also enables the runtime's optimization to achieve the best performance on HoloLens 2. Alternatives to using a texture array, such as double-wide rendering or a separate swapchain per eye, will result in runtime post-processing, which comes at a significant performance penalty.
