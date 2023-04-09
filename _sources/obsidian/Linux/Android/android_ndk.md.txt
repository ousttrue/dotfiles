[Fetching Title#667o](https://gitlab.freedesktop.org/xrdesktop/xrdesktop)[[Android]]
[[ndk_gdbserver]]
[[gradle]]

`ANDROID_NDK_HOME=%ANDROID_HOME%\ndk\25.1.8937393`

# %ANDROID_NDK_HOME%/platfomrs

# dev
## vscode
- @2019 [Using Visual Studio Code as an Android C++ editor – Donald Munro – YABB (Yet Another Boring Blog)](https://donaldmunro.github.io/VSCode-Android-CC/)
## ubuntu
- [Ubuntu で Android NDK を使ってみる](https://www.kkaneko.jp/pro/js/andk.html)
## arch
- [Android - ArchWiki](https://wiki.archlinux.jp/index.php/Android)
- [AUR (en) - android-ndk](https://aur.archlinux.org/packages/android-ndk)

# version
[[gradle|AGP]] のバージョンから決める？

# ABI
- [Android ABI  |  Android NDK  |  Android Developers](https://developer.android.com/ndk/guides/abis?hl=ja)


# build
- [NDK と CMake のインストールと設定  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/projects/install-ndk?hl=ja)

## ndk-build
- @2020 [【Android Studio】NDKを使ってHelloWorld_手動ビルド【日本語】│夢と働き方と日々の生活 x 革命](https://kehalife.com/android-studio-ndk-manual/)
- @2018 [Android Studioでndk-buildを使う - Qiita](https://qiita.com/kenma/items/598496840eef775db142)

`jni/Android.mk`
`jni/Application.mk`

```
ndk_envars = ["ANDROID_NDK", "NDKROOT", "ANDROID_NDK_HOME"]
sdk_envars = ["ANDROID_HOME"]
```

## CMake
- [CMake  |  Android NDK  |  Android Developers](https://developer.android.com/ndk/guides/cmake?hl=ja)
- [CMake - Qiita](https://qiita.com/niusounds/items/1c799475caf981eb2335)

### cmake version
- [Android Studioでデフォルトのcmake以外(ぶっちゃけcmake3.10)も使いたいのじゃ | 車輪の再発見みたいな？](https://serenegiant.com/blog/?p=3676)

### gradle からの呼び出し
- [CMake  |  Android NDK  |  Android Developers](https://developer.android.com/ndk/guides/cmake?hl=ja)
```
-H${HOME}/Dev/github-projects/googlesamples/ndk-samples/hello-jni/app/src/main/cpp
-DCMAKE_FIND_ROOT_PATH=${HOME}/Dev/github-projects/googlesamples/ndk-samples/hello-jni/app/.cxx/cmake/universalDebug/prefab/armeabi-v7a/prefab
-DCMAKE_BUILD_TYPE=Debug
-DCMAKE_TOOLCHAIN_FILE=${HOME}/Android/Sdk/ndk/22.1.7171670/build/cmake/android.toolchain.cmake
-DANDROID_ABI=armeabi-v7a
-DANDROID_NDK=${HOME}/Android/Sdk/ndk/22.1.7171670
-DANDROID_PLATFORM=android-23
-DCMAKE_ANDROID_ARCH_ABI=armeabi-v7a
-DCMAKE_ANDROID_NDK=${HOME}/Android/Sdk/ndk/22.1.7171670
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON
-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=${HOME}/Dev/github-projects/googlesamples/ndk-samples/hello-jni/app/build/intermediates/cmake/universalDebug/obj/armeabi-v7a
-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=${HOME}/Dev/github-projects/googlesamples/ndk-samples/hello-jni/app/build/intermediates/cmake/universalDebug/obj/armeabi-v7a
-DCMAKE_MAKE_PROGRAM=${HOME}/Android/Sdk/cmake/3.10.2.4988404/bin/ninja
-DCMAKE_SYSTEM_NAME=Android
-DCMAKE_SYSTEM_VERSION=23
-B${HOME}/Dev/github-projects/googlesamples/ndk-samples/hello-jni/app/.cxx/cmake/universalDebug/armeabi-v7a
-GNinja
```

## rust
[Android NDK で Rust は使えるのか？調査してみた｜NAVITIME_Tech｜note](https://note.com/navitime_tech/n/n7c758204b362)

# vscode
- @2019 [Using Visual Studio Code as an Android C++ editor – Donald Munro – YABB (Yet Another Boring Blog)](https://donaldmunro.github.io/VSCode-Android-CC/)
- [Using Visual Studio Code as an Android C++ editor – Donald Munro – YABB (Yet Another Boring Blog)](https://donaldmunro.github.io/VSCode-Android-CC/)
```json
{
    "cmake.generator": "Ninja",
    "cmake.configureSettings": {
        "CMAKE_TOOLCHAIN_FILE": "${env:ANDROID_HOME}/ndk/21.0.6113669/build/cmake/android.toolchain.cmake",
        "CMAKE_EXPORT_COMPILE_COMMANDS": "ON",
        "ANDROID_PLATFORM": "android-23",
        "ANDROID_ABI": "armeabi-v7a",
        "CMAKE_ANDROID_ARCH_ABI": "armeabi-v7a",
    },
    "clangd.arguments": [
        "--compile-commands-dir=${workspaceFolder}/build"
    ],
}
```

# samples
## OpenGLES 2.0
[[OpenGLES]]
- [Android：Android NDK で OpenGL – しかるのち](https://shikarunochi.matrix.jp/?p=4097)

- [ndk-samples/hello-gl2 at main · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/main/hello-gl2)
- [GitHub - tenpercent/Android-NDK-OpenGLES2-basic-geometry: "hello-triangle"-inspired example using GLSurfaceView to display stuff and native OpenGL ES 2 routines to render stuff](https://github.com/tenpercent/Android-NDK-OpenGLES2-basic-geometry)

## OpenGLES3.0
```build.gradle
def platformVersion = 24      // openGLES 3.2 min api level  
// def platformVersion = 18    //openGLES 3 min api level  
// def platformVersion = 12    //openGLES 2 min api level
```

動いた
- [ndk-samples/gles3jni at master · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/master/gles3jni/)
- [ndk-samples/teapots at main · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/main/teapots)
