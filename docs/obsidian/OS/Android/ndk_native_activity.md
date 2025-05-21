# NativeActivity

- [Android VulkanでCamera画像を表示する。 #android開発 - Qiita](https://qiita.com/kwhrstr1206/items/44fb2b6f89126cf78437)
- https://github.com/kwhrstr/VulkanWithCamera/tree/master

- [`NativeActivity`](https://developer.android.com/ndk/guides/concepts?hl=ja#naa)
- [ndk-samples/native-activity at main · android/ndk-samples · GitHub](https://github.com/android/ndk-samples/tree/main/native-activity)
- [Android Native Activity アプリの作成 | Microsoft Learn](https://learn.microsoft.com/ja-jp/cpp/cross-platform/create-an-android-native-activity-app?view=msvc-170)
- @2010 [NATIVEACTIVITYクラスを用いたアプリケーションを実行する。](https://techbooster.org/android/2239/)

```xml
<manifest>
  <application>
    <activity>
      <meta-data android:name="android.app.lib_name"
                 android:value="native-activity" /> <!-- libnative-activity.so -->
      <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
      </intent-filter>
    </activity>
  </application>
</manifest>
```

# NDK

- @2015 [C++によるAndroid NDK NativeActivityサンプル | Misohena Blog](https://misohena.jp/blog/2015-06-28-cpp-impl-android-native-activity-sample.html)

# GameActivity

- [NativeActivity から移行する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/games/agdk/game-activity/migrate-native-activity?hl=ja)
