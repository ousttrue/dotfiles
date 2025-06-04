[GStreamer: open source multimedia framework](https://gstreamer.freedesktop.org/)

- @2019 [OpenCVのgstreamerでキャプチャすると遅延が少なかったメモ(仮) - Qiita](https://qiita.com/nakasuke_/items/84ec6cb3ddc9dee003c2)
- @2010 [あしたのオープンソース研究所: GStreamer - 2010-01-11 - ククログ](https://www.clear-code.com/blog/2010/1/11.html)
- [呪いのビデオをGStreamerで作る - Qiita](https://qiita.com/araki-yzrh/items/2bd1fc899ea157f704e4)

- https://github.com/dabrain34/GstPipelineStudio

# Version

## 1.20

# Install

## windows

`COMPLETE` でインストールするべし

# build

- [GitHub - GStreamer/gstreamer: GStreamer open-source multimedia framework](https://github.com/GStreamer/gstreamer)

- [gStreamer/Pluginのビルド手順(Ubuntu, Windows) - Qiita](https://qiita.com/nakakura/items/4b2c1c312236ea96824b)
- [Windows版GStreamerのバージョン1.18以降での変更点 - h2oとphp8でwp](https://e-kamo.net/gstreamer-for-win-version-diffarence)

## gtk4

- [GStreamer / gst-plugins-rs · GitLab](https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs)

## Meson

- [Building from source using Meson](https://gstreamer.freedesktop.org/documentation/installing/building-from-source-using-meson.html)

# tutorial

- [Tutorials](https://gstreamer.freedesktop.org/documentation/tutorials/index.html?gi-language=c)
- [Basic tutorials](https://gstreamer.freedesktop.org/documentation/tutorials/basic/index.html): Describe general topics required to understand the rest of tutorials in GStreamer.
- [Playback tutorials](https://gstreamer.freedesktop.org/documentation/tutorials/playback/index.html): Explain everything you need to know to produce a media playback application using GStreamer.
- [Android tutorials](https://gstreamer.freedesktop.org/documentation/tutorials/android/index.html): Tutorials dealing with the few Android-specific topics you need to know.
- [iOS tutorials](https://gstreamer.freedesktop.org/documentation/tutorials/ios/index.html): Tutorials dealing with the few iOS-specific topics you need to know.

# 列挙

## gst-device-monitor-1.0

# Elements

- [CoreElements について - Qiita](https://qiita.com/tetsukuz/items/8438f993afe068d66d40#valve)

## src

### ctrl-c で止める

```
> gst-launch-1.0  -e
```

### autovideosrc

- [GStreamer on macOS ではじめる動画処理【video編】 | DevelopersIO](https://dev.classmethod.jp/articles/gstreamer-on-macos-video/)
- [[Kinesis Video Streams] Mac上で各種ソースからの動画のアップロード 〜 kvssinkを利用する場合のGStreamerの使用方法 | DevelopersIO](https://dev.classmethod.jp/articles/amazon-kinesis-vidseo-streams-gstreams-kvssynk/)

```
> gst-launch-1.0 autovideosrc ! videoconvert ! video/x-raw ! autovideosink
```

### ksvideosrc

- [gstreamer備忘録 - Qiita](https://qiita.com/yusukem99/items/11d94cf26fbac673718c)

```
> gst-launch-1.0 ksvideosrc ! videoconvert ! video/x-raw ! autovideosink
```

### dshowvideosrc

`要自前ビルド`

- [c++ - GStreamer Win x64 -- is dshowvideosrc missing? - Stack Overflow](https://stackoverflow.com/questions/44774191/gstreamer-win-x64-is-dshowvideosrc-missing)

```
> gst-launch-1.0.exe dshowvideosrc device-index=4 ! videoconvert ! video/x-raw ! autovideosink
```

## sink

## autovideosink

```
> gst-launch-1.0 videotestsrc ! autovideosink
```

### kvssink

- [[Kinesis Video Streams] Windows上で各種ソースからの動画のアップロード 〜 kvssinkを利用する場合のGStreamerの使用方法 | DevelopersIO](https://dev.classmethod.jp/articles/kinesis-video-streams-gstreamer-windows/)

### filesink

- [【Mac】Gstremerで動画を保存する方法 - Qiita](https://qiita.com/MONSOON/items/d1023fb1c100c4650579)

## encoder

### nvenc264h

- [https://developer.download.nvidia.com/embedded/L4T/r24_Release_v2.1/Docs/Accelerated_GStreamer_User_Guide_Release_24.2.1.pdf](https://developer.download.nvidia.com/embedded/L4T/r24_Release_v2.1/Docs/Accelerated_GStreamer_User_Guide_Release_24.2.1.pdf)

```
> gst-launch-1.0.exe -e dshowvideosrc device-index=4 ! videoconvert ! nvh264enc ! 'video/x-h264, streamformat=(string)byte-stream' ! h264parse ! qtmux ! filesink location=test.mp4 -e
```

# WebRTC

- [GStreamer で WebRTC を使用する](https://www.gclue.jp/2022/07/gstreamer-webrtc.html)

# SRT

# RTSP

- [Unityのカメラ映像をRTSPストリームで出力する - Qiita](https://qiita.com/hiro-han/items/a20c9710d808e27f0ef2)
- [GstreamerでRTSPを使った動画の送受信と保存 - Qiita](https://qiita.com/bigface00/items/7c1f568dba96c34ec077)
- [macでrtspサーバを立てる - Qiita](https://qiita.com/k-yamada-github/items/1deaa6e81081e4a1aa35)

# C

- [Basic tutorial 5: GUI toolkit integration](https://gstreamer.freedesktop.org/documentation/tutorials/basic/toolkit-integration.html?gi-language=c)

# opencv

- [OpenCVのGstreamerバックエンドで高度な動画キャプチャを実現する - Qiita](https://qiita.com/stnk20/items/242e400853579d511ea3)

# gstgl

- [plugins/glbox.py - edgetpuvision - Git at Google](https://coral.googlesource.com/edgetpuvision/+/refs/heads/release-day/plugins/glbox.py)
- [gst-plugins-base/gstopengl.c at master · GStreamer/gst-plugins-base · GitHub](https://github.com/GStreamer/gst-plugins-base/blob/master/ext/gl/gstopengl.c)

# gtksink

- [gtk: add GTK4 support (!767) · Merge requests · GStreamer / gst-plugins-good · GitLab](https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/merge_requests/767)

- subprojects/gst-plugins-good/tests/examples/gtk/gtksink.c
- subprojects/gst-plugins-good/ext/gtk/gstgtksink.h
- subprojects/gst-plugins-good/ext/gtk/gstgtksink.c
