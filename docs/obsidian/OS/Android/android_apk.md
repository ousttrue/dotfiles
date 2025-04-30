# 構成

- [APKファイルのダウンロードとファイル構造、解析方法のまとめ - Gazee](https://gazee.net/develop/apk-structure/)

- `assets`
- `lib`
  - armeabi-v7a
  - arm64-v8a
- `META-INF`
- `res`
- `AndroidManifest.xml`
- `classes.dex`
- `resources.arsc`

# AndroidManifest.xml

https://developer.android.com/guide/topics/manifest/manifest-intro

- manifest:(package)
- application.activity:(android.name => class 名)

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    package="com.hoge.fuga">

    <application
        tools:targetApi="31">
        <activity
            android:name="android.app.NativeActivity"
        </activity>
    </application>
</manifest>
```

# 作り方

```
> zig build -Dtarget=aarch64-linux-android --summary all
Build Summary: 20/20 steps succeeded
install cached
└─ install generated to minimal.apk cached
   └─ zig-android-sdk apksigner cached
      ├─ zig-android-sdk keytool cached
      └─ zig-android-sdk zipalign cached
         ├─ zig-android-sdk jar (zip compress apk) cached
         │  ├─ WriteFile lib\arm64-v8a\libmain.so cached
         │  │  ├─ zig build-lib minimal Debug aarch64-linux-android cached 43ms MaxRSS:19M
         │  │  │  ├─ WriteFile android-libc_target-aarch64-linux-android_version-35_ndk-29.0.13113456.conf cached
         │  │  │  ├─ WriteFile android-libc_target-aarch64-linux-android_version-35_ndk-29.0.13113456.conf (reused)
         │  │  │  └─ options cached
         │  │  │     └─ zig-android-sdk builtin_options_update success
         │  │  │        └─ zig-android-sdk aapt2 dump packagename cached
         │  │  │           └─ zig-android-sdk aapt2 link cached
         │  │  │              └─ zig-android-sdk aapt2 compile [dir] cached
         │  │  ├─ zig-android-sdk d8 cached
         │  │  │  ├─ zig-android-sdk d8glob success
         │  │  │  │  └─ zig-android-sdk javac cached
         │  │  │  └─ zig-android-sdk javac (reused)
         │  │  ├─ zig-android-sdk aapt2 link (+1 more reused dependencies)
         │  │  └─ zig-android-sdk jar (unzip resources.apk) success 191ms MaxRSS:47M
         │  │     ├─ zig-android-sdk aapt2 link (+1 more reused dependencies)
         │  │     └─ zig-android-sdk aapt2 link (+1 more reused dependencies)
         │  └─ WriteFile lib\arm64-v8a\libmain.so (+4 more reused dependencies)
         └─ zig-android-sdk jar (update zip with uncompressed files) success 336ms MaxRSS:51M
            ├─ WriteFile resources.arsc cached
            │  ├─ zig-android-sdk aapt2 link (+1 more reused dependencies)
            │  └─ zig-android-sdk jar (unzip resources.apk) (+2 more reused dependencies)
            ├─ WriteFile resources.arsc (+2 more reused dependencies)
            └─ zig-android-sdk jar (zip compress apk) (+2 more reused dependencies)
```
