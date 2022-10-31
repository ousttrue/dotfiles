[[Android]]
[[ndk_gdbserver]]

- [NDK と CMake のインストールと設定  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/projects/install-ndk?hl=ja)
- @2020 [【Android Studio】NDKを使ってHelloWorld_手動ビルド【日本語】│夢と働き方と日々の生活 x 革命](https://kehalife.com/android-studio-ndk-manual/)

`%ANDROID_HOME%\ndk\25.1.8937393`

```
ndk_envars = ["ANDROID_NDK", "NDKROOT", "ANDROID_NDK_HOME"]
sdk_envars = ["ANDROID_HOME"]
```

# vscode
- @2019 [Using Visual Studio Code as an Android C++ editor – Donald Munro – YABB (Yet Another Boring Blog)](https://donaldmunro.github.io/VSCode-Android-CC/)

# OpenGLES 2.0
[[OpenGLES]]
- [Android：Android NDK で OpenGL – しかるのち](https://shikarunochi.matrix.jp/?p=4097)

動かん
- [ndk-samples/hello-gl2 at main · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/main/hello-gl2)
- [GitHub - tenpercent/Android-NDK-OpenGLES2-basic-geometry: "hello-triangle"-inspired example using GLSurfaceView to display stuff and native OpenGL ES 2 routines to render stuff](https://github.com/tenpercent/Android-NDK-OpenGLES2-basic-geometry)

# OpenGLES3.0
```build.gradle
def platformVersion = 24      // openGLES 3.2 min api level  
// def platformVersion = 18    //openGLES 3 min api level  
// def platformVersion = 12    //openGLES 2 min api level
```

動いた
- [ndk-samples/gles3jni at master · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/master/gles3jni/)
- [ndk-samples/teapots at main · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/main/teapots)

# CMake
- [CMake  |  Android NDK  |  Android Developers](https://developer.android.com/ndk/guides/cmake?hl=ja)

## Gradle プラグインの ExternalNativeBuild
- [CMake - Qiita](https://qiita.com/niusounds/items/1c799475caf981eb2335)

# ndk

## cmake version
- [Android Studioでデフォルトのcmake以外(ぶっちゃけcmake3.10)も使いたいのじゃ | 車輪の再発見みたいな？](https://serenegiant.com/blog/?p=3676)

## ubuntu
- [Ubuntu で Android NDK を使ってみる](https://www.kkaneko.jp/pro/js/andk.html)

## arch
- [Android - ArchWiki](https://wiki.archlinux.jp/index.php/Android)
- [AUR (en) - android-ndk](https://aur.archlinux.org/packages/android-ndk)
