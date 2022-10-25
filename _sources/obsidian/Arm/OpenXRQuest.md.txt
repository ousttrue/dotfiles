[[Android]]
[[OpenXR]]

# Oculus OpenXR Mobile SDK

- [Site Unreachable](https://developer.oculus.com/downloads/package/oculus-openxr-mobile-sdk/)
	- [Build and Run hello_xr Sample App](https://developer.oculus.com/documentation/native/android/mobile-build-run-hello-xr-app/)


```
OpenXRMobileSDK # MobileSDK
OpenXR-SDK-Source # github KhronosGroup/OpenXR-SDK-Source
```


- @2021 [ネイティブ開発Ouclus Quest2 - Qiita](https://qiita.com/tkymt/items/f40d201c42a88da23824)

- [GitHub - terryky/android_openxr_gles: VR sample applications on Android NDK using OpenXR + OpenGLES. (especially for Meta Quest2)](https://github.com/terryky/android_openxr_gles)
- [GitHub - Wxz234/Android-Oculus: A Openxr](https://github.com/Wxz234/Android-Oculus)

## android.manifest

```xml
<intent-filter>
    <action android:name="android.intent.action.MAIN" />
    <category android:name="com.oculus.intent.category.VR" />
    <category android:name="android.intent.category.LAUNCHER" />
</intent-filter>
```
