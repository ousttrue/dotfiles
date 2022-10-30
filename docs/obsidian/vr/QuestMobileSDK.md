[[QuestMobileSDK]]
[[Android]]
[[android_ndk]]
[[QuestMobileSDK]]
[[OpenXR]]

- [Android開発ソフトウェアの設定](https://developer.oculus.com/documentation/native/android/mobile-studio-setup-android/)

- Android SDKプラットフォーム、APIレベル26
	- Android 8.0 (Oreo)
- Android SDKビルドツール、v28.0.3以降
- Android NDK

- @2021 [ネイティブ開発Ouclus Quest2 - Qiita](https://qiita.com/tkymt/items/f40d201c42a88da23824)

- [GitHub - terryky/android_openxr_gles: VR sample applications on Android NDK using OpenXR + OpenGLES. (especially for Meta Quest2)](https://github.com/terryky/android_openxr_gles)
- [GitHub - Wxz234/Android-Oculus: A Openxr](https://github.com/Wxz234/Android-Oculus)

# Oculus Developer Hub

- [Oculus Developer Hub for Windows](https://developer.oculus.com/downloads/package/oculus-developer-hub-win/)
- [Oculus Quest 2 入門 (1) - Oculus Developer Hub の使い方｜npaka｜note](https://note.com/npaka/n/nc18d61e25c85)

# vscode
- [Using Oculus Debugger for VS Code](https://developer.oculus.com/documentation/native/android/ts-oculus-debugger/)

# Quest向け openxr_loader
- [Build and Run hello_xr Sample App](https://developer.oculus.com/documentation/native/android/mobile-build-run-hello-xr-app/)

# xrSamples
- [Mobile OpenXR Samples](https://developer.oculus.com/documentation/native/android/mobile-openxr-sample/)

##  [XR_EXT_hand_tracking](https://microsoft.github.io/OpenXR-MixedReality/openxr_preview/specs/openxr.html#XR_EXT_hand_tracking): xrHandsFB
- [Enable Hand Tracking](https://developer.oculus.com/documentation/native/android/mobile-hand-tracking/)

```c++
// Inspect hand tracking system properties
XrSystemHandTrackingPropertiesEXT handTrackingSystemProperties{
	XR_TYPE_SYSTEM_HAND_TRACKING_PROPERTIES_EXT
};
XrSystemProperties systemProperties{
	XR_TYPE_SYSTEM_PROPERTIES, &handTrackingSystemProperties
};
OXR(xrGetSystemProperties(GetInstance(), GetSystemId(), &systemProperties));
```

`xrSamples/XrHandsFB/Projects/Android/build.gradle` ?

> Demonstrates how to use hand tracking to drive simple pointer-based input and provide visual feedback for hand meshes and simple skinning.

- @2021 [VR/ARの標準仕様「OpenXR」、Oculus Questのハンドトラッキングが正式対応 | Think IT（シンクイット）](https://thinkit.co.jp/article/19064)

# Movement SDK
- [# Movement SDK for OpenXR](https://developer.oculus.com/documentation/native/android/move-overview/)
- [Movement SDK OpenXR API Reference](https://developer.oculus.com/documentation/native/android/move-ref-api/)

## XR_FB_body_tracking
- [Movement Body Tracking OpenXR Extension](https://developer.oculus.com/documentation/native/android/move-body-tracking/)

## XR_FB_face_tracking
- [Face Tracking in Movement SDK for OpenXR](https://developer.oculus.com/documentation/native/android/move-face-tracking/)

## XR_FB_eye_tracking_social
- [Eye Tracking in Movement SDK for OpenXR](https://developer.oculus.com/documentation/native/android/move-eye-tracking/)

# PassThrough
- xrSamples/XrPassthrough
- [XR_FB_passthrough](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_passthrough&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw) 
- [XR_FB_triangle_mesh](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_triangle_mesh&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw).

# Scene
- xrSample/XrSceneModel
- [OpenXR Scene Overview](https://developer.oculus.com/documentation/native/android/openxr-scene-overview/)
- [XR_FB_scene](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_scene&e=AT3BlXnZRaCRe3CYW1HdeKPUir-iED7cVDTAHr6XyLkO37MChTgxY1YrEI7GFnRp17TK4YdZtwvxQm8P4u9abNA9LZPRsf8jKfnIgHGZb1RYPTl0aOvKq-7awsGtsHnUClFcQTbONNOj1wlX721aYOppizfRCy3s0sIO8Q).

# SpatialAnchors
- [# Spatial Anchors Overview](https://developer.oculus.com/documentation/native/android/openxr-lsa-overview/)
- xrSamples/XrSpatialAnchor
-   XR_FB_spatial_entity
-   XR_FB_spatial_entity_storage
-   XR_FB_spatial_entity_query
-   XR_FB_spatial_entity_container
 
# Unity
- [はじめての Oculus Quest アプリの作成 ｜npaka｜note](https://note.com/npaka/n/n749a134d0c11)
- [Oculus Integration | 機能統合 | Unity Asset Store](https://assetstore.unity.com/packages/tools/integration/oculus-integration-82022)
