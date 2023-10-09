[[gstreamer]]

# RTSP
[[RTSP]]

- @2023 `qsvh264dec` `qsvh264enc` [GStreamerを使う](https://zenn.dev/noshimochi/articles/412d44d0390df9)
- @2021 [Unityのカメラ映像をRTSPストリームで出力する - Qiita](https://qiita.com/hiro-han/items/a20c9710d808e27f0ef2)

- [ネットワークカメラのRTSPをgstreamerで読み込む際に、gstreamer1.0-plugins-uglyをアンインストールするとうまくいった話 - Qiita](https://qiita.com/tsota/items/b27dc855bde8e2fc7905)

# gst-rtsp-server
- [GitHub - GStreamer/gst-rtsp-server: RTSP server based on GStreamer. This module has been merged into the main GStreamer repo for further development.](https://github.com/GStreamer/gst-rtsp-server)
- [gst-rtsp-server/examples at master · GStreamer/gst-rtsp-server · GitHub](https://github.com/GStreamer/gst-rtsp-server/tree/master/examples)
- [AMD アダプティブ コンピューティング資料ポータル](https://docs.xilinx.com/r/ja-JP/ug1449-multimedia/RTSP-%E3%82%B9%E3%83%88%E3%83%AA%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0-%E3%83%91%E3%82%A4%E3%83%97%E3%83%A9%E3%82%A4%E3%83%B3)

## api

```c++
auto server = gst_rtsp_server_new();
```

## test-launch
- `v4l2src` @2021 [GstreamerでRTSPを使った動画の送受信と保存 - Qiita](https://qiita.com/bigface00/items/7c1f568dba96c34ec077)
- `videotestsrc`@2020 [[Kinesis Video Streams] GStreamerを使用したRTSPサーバを構築し、Macから動画を送信してみました。 | DevelopersIO](https://dev.classmethod.jp/articles/amazon-kinesis-vidseo-streams-gstreamer-rtsp-server/)
```sh
$ GST_DEBUG=3. /test-launch '( videotestsrc ! x264enc ! rtph264pay name=pay0 pt=96 )'
```
👆
client OK: `vlc`
`rtsp://127.0.0.1:8554/test`

client OK: `gst`
```sh
$ gst-launch-1.0 rtspsrc location=rtsp://127.0.0.1:8554/test ! decodebin ! autovideosink
```

# rtspclientsink (publish)
- `rtspclientsink` @2022 [macでrtspサーバを立てる - Qiita](https://qiita.com/k-yamada-github/items/1deaa6e81081e4a1aa35)
```
$ gstk-launch-1.0 videotestsrc ! timeoverlay font-desc="Sans 36" ! capsfilter caps="video/x-raw" ! queue ! x264enc ! rtspclientsink location=rtsp://localhost:8554/mystream
```

x264 などのrtspが対応するvideoエンコーディlングが必要(rawはだめ)

# rtspsrc (client)
- [rtspsrc](https://gstreamer.freedesktop.org/documentation/rtsp/rtspsrc.html?gi-language=c)

localhost ではだめだった?host名注意！
```
$ rtspsrc location=rtsp://127.0.0.1:8554/mystream ! decodebin ! autovideosink
```

- `capsfilter` @2020 [GStreamerでの映像+音声RTP/RTSPの再生 – Kenchant](https://senooken.jp/post/2020/11/20/4781/)

# RTP
- `udpsink` `udpsrc` @2022 [GStreamer を使用した端末間での映像転送](https://www.gclue.jp/2022/06/gstreamer.html)
- `udpsink` `udpsrc` @2020 [gstreamerでrtp経由でストリーミング - Elsaの技術日記(徒然なるままに)](https://elsammit-beginnerblg.hatenablog.com/entry/2020/12/05/224128)
- `udpsink` `udpsrc` [gstreamer備忘録 - Qiita](https://qiita.com/maueki/items/b54cbe5207bb16869756)
