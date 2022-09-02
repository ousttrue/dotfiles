[[arm_snapdragon]]
[[zig]]
[[OpenXRQuest]]

`/app/build/outputs/apk`

# version
[Android Releases  |  Android Developers](https://developer.android.com/about/versions?hl=ja)

|Android| API level | device |
|-|-|-|
|13|| beta |
| 12| 31| pixel3a |
|7||nougat|
|6||lolipop|
|5|||
|4||ICS|
|3||gingerbred|


- [java - Android Studio error: "Manifest merger failed: Apps targeting Android 12" - Stack Overflow](https://stackoverflow.com/questions/67412084/android-studio-error-manifest-merger-failed-apps-targeting-android-12)


# sdkmanager
`/opt/android-sdk/tools/bin/sdkmanager`
- [sdkmanager で jdk バージョン違いでこけるのを対処する](https://zenn.dev/ryotabannai/articles/9a55a051289cd819c96a)

> sdkmanager が version8 までしか対応していない

- [Java 9 で deprecated になったモジュールによる例外発生の問題にちゃんと対処したい - k11i.biz](https://k11i.biz/blog/2018/06/26/maven-artifacts-for-java9-deprecated-modules/)
- [android: sdkmanagerを起動すると、NoClassDefFoundErrorで起動できない | Ninton](https://www.ninton.co.jp/archives/2723)

```
// This has been removed from the JDK with version 11+
java.lang.module.FindException: Module java.xml.bind not found
```

- [Androidのlicencesのエラーを解決 - Qiita](https://qiita.com/joji/items/931d5f4e4ee853d7458c)

# ndk

## cmake version
- [Android Studioでデフォルトのcmake以外(ぶっちゃけcmake3.10)も使いたいのじゃ | 車輪の再発見みたいな？](https://serenegiant.com/blog/?p=3676)

## ubuntu
- [Ubuntu で Android NDK を使ってみる](https://www.kkaneko.jp/pro/js/andk.html)

## arch
- [Android - ArchWiki](https://wiki.archlinux.jp/index.php/Android)
- [AUR (en) - android-ndk](https://aur.archlinux.org/packages/android-ndk)

# apk
# zig
- [GitHub - MasterQ32/ZigAndroidTemplate: This repository contains a example on how to create a minimal Android app in Zig.](https://github.com/MasterQ32/ZigAndroidTemplate)
- [GitHub - MasterQ32/zero-graphics: Application framework based on OpenGL ES 2.0. Runs on desktop machines, Android phones and the web](https://github.com/MasterQ32/zero-graphics)
