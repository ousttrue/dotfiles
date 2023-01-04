---
aliases: [ovr_openxr_mobile_sdk]
---

[[Android]] [[android_ndk]]
[[OpenXR]] [[MovementSDK]] [[QuestKeyboard]] [[XrSpace]]

- [OpenXR Mobile SDK](https://developer.oculus.com/documentation/native/android/mobile-intro/)

# Version
## v0.47

## v0.46
`quest pro`

# Android
- [Android開発ソフトウェアの設定](https://developer.oculus.com/documentation/native/android/mobile-studio-setup-android/)

- Android SDKプラットフォーム、APIレベル26
	- Android 8.0 (Oreo)
- Android SDKビルドツール、v28.0.3以降
- Android NDK

- @2021 [ネイティブ開発Ouclus Quest2 - Qiita](https://qiita.com/tkymt/items/f40d201c42a88da23824)

- [GitHub - Wxz234/Android-Oculus: A Openxr](https://github.com/Wxz234/Android-Oculus)

# OVRPlugin
`1.78` => OpenXR backend ?

# SampleXrFramework
## XrApp

# samples
- [GitHub - terryky/android_openxr_gles: VR sample applications on Android NDK using OpenXR + OpenGLES. (especially for Meta Quest2)](https://github.com/terryky/android_openxr_gles)

# Oculus Developer Hub
https://note.com/npaka/n/nc18d61e25c85
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

# Unity
- [はじめての Oculus Quest アプリの作成 ｜npaka｜note](https://note.com/npaka/n/n749a134d0c11)
- [Oculus Integration | 機能統合 | Unity Asset Store](https://assetstore.unity.com/packages/tools/integration/oculus-integration-82022)
