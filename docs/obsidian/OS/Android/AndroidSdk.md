`Windows` にコマンドラインで導入するには？

下の方 `Command line tools`

# install

default

`%LOCALAPPDATA%\Android\Sdk`

custom

`ANDROID_HOME=D:/android_sdk`

## cmdline-tools

- https://developer.android.com/studio/command-line?hl=ja#tools-sdk
- @2020 [最新の Android command-line tools のセットアップ | by Jumpei Matsuda | Medium](https://medium.com/@jmatsu.drm/%E6%9C%80%E6%96%B0%E3%81%AE-android-command-line-tools-%E3%81%AE%E3%82%BB%E3%83%83%E3%83%88%E3%82%A2%E3%83%83%E3%83%97-1f99605e6bee)
  `commandlinetools-win-10406996_latest.zip`
  👇
  `%ANDROID_HOME%/cmdline-tools/latest`

## Java

[[java]]

### JetBrainsRuntime

https://github.com/JetBrains/JetBrainsRuntime

Java jbr を展開

`JAVA_HOME=D:/Java/jbr_jcef-17.0.8.1-windows-x64-b1080.1`

### JetBrainsRuntime AndroidStudio

`D:/Program Files/Android/Android Studio/jbr`

# sdkmanager

[sdkmanager  |  Android Studio  |  Android Developers](https://developer.android.com/tools/sdkmanager)

```sh
> %ANDROID_HOME%/cmdline-tools/latest/bin/sdkmanager.bat --list_installed
```

# platform-tools

```
> sdkmanager --install platform-tools
```

[[android_adb]]
