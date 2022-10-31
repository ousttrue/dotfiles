Android Debug Bridge

[[Android]]
[[QuestMobileSDK]]

- [Android Debug Bridge（adb）  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/command-line/adb?hl=ja)
-  [ADBでよく使うコマンド一覧 - Qiita](https://qiita.com/uhooi/items/fb103ad3e263b0bb0abf#adb%E3%81%A7%E3%82%88%E3%81%8F%E4%BD%BF%E3%81%86%E3%83%86%E3%82%AF%E3%83%8B%E3%83%83%E3%82%AF)

`ANDROID_HOME=%USERPROFILE%\AppData\Local\Android\Sdk`
`%ANDROID_HOME/platform-tools/adb.exe`

```
$ adb devices -l
```

# driver
開発者モードが必要

## Google
- [Google USB ドライバを入手する  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/run/win-usb?hl=ja)

## Quest
- [[Oculus Quest] adb接続する | script life 千夜一夜 プログラミング別館](https://www.scriptlife.jp/contents/programming/2019/06/23/oculus-quest-adb/)

## device 認識
- [Site Unreachable](https://developer.oculus.com/downloads/package/oculus-adb-drivers/?locale=ja_JP)
```
List of devices attached
1PASH9BHD29144         unauthorized transport_id:1
```

# apk 起動
```
$ adb shell am start -n "com.example.gl2handtrackOXR/com.oxrapp.glesapp.OXRAppMainActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER -D
```
