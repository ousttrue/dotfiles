# project

`7.3.1`

```groovy
// build.gradle
// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {

    repositories {
       google()
       mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.1'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

フォルダ構成

> `AndroidStudio` で `c++` に `breakpoint` を置きたいので root の子孫の `c++` のソースを配置するべし

> CMakeLists.txt で親ディレクトリに対する `subdirs` を避けるべし。かつ浅めのフォルダに配置

- root/
  - build.gradle
  - settigns.gradle
  - CMakeLists.txt
  - app/
    - build.gradle
      - src/
        - main/
          - AndroidManifest.xml
          - res/
  - cpp/
    - CMakeLists.txt

## app

```groovy
// settings.gradle
include ':app'
```

`/app/build/outputs/apk`

# lint

- [Android Lintと修正方法 - Qiita](https://qiita.com/yoppie_x/items/4ada5a4c12ff9fd057a4)

# version

[Android Releases  |  Android Developers](https://developer.android.com/about/versions?hl=ja)

| Android | API level | device     |
| ------- | --------- | ---------- |
| 13      |           | beta       |
| 12      | 31        | pixel3a    |
| 7       |           | nougat     |
| 6       |           | lolipop    |
| 5       |           |            |
| 4       |           | ICS        |
| 3       |           | gingerbred |

- [java - Android Studio error: "Manifest merger failed: Apps targeting Android 12" - Stack Overflow](https://stackoverflow.com/questions/67412084/android-studio-error-manifest-merger-failed-apps-targeting-android-12)

# 環境変数

- [環境変数  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/command-line/variables?hl=ja)

# sdkmanager

`/opt/android-sdk/tools/bin/sdkmanager`

- [sdkmanager で jdk バージョン違いでこけるのを対処する](https://zenn.dev/ryotabannai/articles/9a55a051289cd819c96a)

> sdkmanager が java8 までしか対応していない

- [Java 9 で deprecated になったモジュールによる例外発生の問題にちゃんと対処したい - k11i.biz](https://k11i.biz/blog/2018/06/26/maven-artifacts-for-java9-deprecated-modules/)
- [android: sdkmanagerを起動すると、NoClassDefFoundErrorで起動できない | Ninton](https://www.ninton.co.jp/archives/2723)

```
// This has been removed from the JDK with version 11+
java.lang.module.FindException: Module java.xml.bind not found
```

- [Androidのlicencesのエラーを解決 - Qiita](https://qiita.com/joji/items/931d5f4e4ee853d7458c)
