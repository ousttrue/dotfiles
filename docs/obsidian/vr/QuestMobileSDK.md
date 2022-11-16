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

- [GitHub - Wxz234/Android-Oculus: A Openxr](https://github.com/Wxz234/Android-Oculus)

# samples
- [GitHub - terryky/android_openxr_gles: VR sample applications on Android NDK using OpenXR + OpenGLES. (especially for Meta Quest2)](https://github.com/terryky/android_openxr_gles)

# Oculus Developer Hub

- [Oculus Developer Hub for Windows](https://developer.oculus.com/downloads/package/oculus-developer-hub-win/)
- [Oculus Quest 2 入門 (1) - Oculus Developer Hub の使い方｜npaka｜note](https://note.com/npaka/n/nc18d61e25c85)

# vscode
- [Using Oculus Debugger for VS Code](https://developer.oculus.com/documentation/native/android/ts-oculus-debugger/)

# Quest向け openxr_loader
- [Build and Run hello_xr Sample App](https://developer.oculus.com/documentation/native/android/mobile-build-run-hello-xr-app/)

# xrSamples
- [Mobile OpenXR Samples](https://developer.oculus.com/documentation/native/android/mobile-openxr-sample/)

## ovrbuild
`bin/scripts/build/ovrbuild.py`
環境変数
- JAVA_HOME = AndroidStudio_INSTALL/jre
- ANDROID_HOME = %USERPROFILE%/AppData/Local/Android/sdk
- ANDROID_NDK_HOME = %ANDROID_HOME%/ndk/NDK_VERSION
が必用。

`D:\OpenXRMobileSDK\bin\scripts\build\../../../gradlew assembleRelease --daemon -quiet --build-cache --configure-on-demand --parallel -Pshould_install`

## XR_EXT_hand_tracking & XR_FB_hand_tracking_mesh
[[XR_EXT_hand_tracking]]

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
- [パススルー機能を使うには](https://framesynthesis.jp/tech/unity/oculusquest/#%E3%83%91%E3%82%B9%E3%82%B9%E3%83%AB%E3%83%BC%E6%A9%9F%E8%83%BD%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AB%E3%81%AF)
- xrSamples/XrPassthrough
- [XR_FB_passthrough](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_passthrough&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw) 
- [XR_FB_triangle_mesh](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_triangle_mesh&e=AT2UPomIZ9jR7kOdzmMWnGa_G0B-j_Wc6QXVBwNoPRG85qJJ1YKV9kYP1IXaRsRfJgGbEWLpqdVusNU7_-X9tTCbSLGeFpBYwTm1MLD8qCV2xvIrqDNqqBEyoJaMqtPRZSjAxsITjSnDCmk5wA6i9IWoJmPSievmJrOYqw).

# Scene
- [【Meta Quest 2】最新アプデでMRセットアップ機能が実装 新しいコンテンツが増える？ - MoguLive](https://www.moguravr.com/meta-quest-2-9/)

- xrSample/XrSceneModel
- [OpenXR Scene Overview](https://developer.oculus.com/documentation/native/android/openxr-scene-overview/)
- [XR_FB_scene](https://www.oculus.com/lynx/?u=https%3A%2F%2Fregistry.khronos.org%2FOpenXR%2Fspecs%2F1.0%2Fhtml%2Fxrspec.html%23XR_FB_scene&e=AT3BlXnZRaCRe3CYW1HdeKPUir-iED7cVDTAHr6XyLkO37MChTgxY1YrEI7GFnRp17TK4YdZtwvxQm8P4u9abNA9LZPRsf8jKfnIgHGZb1RYPTl0aOvKq-7awsGtsHnUClFcQTbONNOj1wlX721aYOppizfRCy3s0sIO8Q).

# SpatialAnchors
- [空間アンカーを使うには](https://framesynthesis.jp/tech/unity/oculusquest/#%E7%A9%BA%E9%96%93%E3%82%A2%E3%83%B3%E3%82%AB%E3%83%BC%E3%82%92%E4%BD%BF%E3%81%86%E3%81%AB%E3%81%AF)
- [# Spatial Anchors Overview](https://developer.oculus.com/documentation/native/android/openxr-lsa-overview/)
- xrSamples/XrSpatialAnchor
-   XR_FB_spatial_entity
-   XR_FB_spatial_entity_storage
-   XR_FB_spatial_entity_query
-   XR_FB_spatial_entity_container

# SampleXrFramework
## XrApp


# Unity
- [はじめての Oculus Quest アプリの作成 ｜npaka｜note](https://note.com/npaka/n/n749a134d0c11)
- [Oculus Integration | 機能統合 | Unity Asset Store](https://assetstore.unity.com/packages/tools/integration/oculus-integration-82022)