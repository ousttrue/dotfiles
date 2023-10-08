[[RTSP]] [[WebRTC]]

- [GitHub - bluenviron/mediamtx: Ready-to-use SRT / WebRTC / RTSP / RTMP / LL-HLS media server and media proxy that allows to read, publish, proxy and record video and audio streams.](https://github.com/bluenviron/mediamtx)

- @2022 [macでrtspサーバを立てる - Qiita](https://qiita.com/k-yamada-github/items/1deaa6e81081e4a1aa35)
- `proxy` @2021 [RTSPプロキシを立てる - モールス練習帖](https://ji1jdi.hatenablog.com/entry/2021/07/19/071027)

- さくっとビルドして、さくっと動く
```sh
% ./mediamtx
2023/10/07 21:27:31 INF MediaMTX v0.0.0
2023/10/07 21:27:31 INF configuration loaded from /home/ousttrue/ghq/github.com/bluenviron/mediamtx/mediamtx.yml
2023/10/07 21:27:31 INF [RTSP] listener opened on :8554 (TCP), :8000 (UDP/RTP), :8001 (UDP/RTCP)
2023/10/07 21:27:31 INF [RTMP] listener opened on :1935
2023/10/07 21:27:31 INF [HLS] listener opened on :8888
2023/10/07 21:27:31 INF [WebRTC] listener opened on :8889 (HTTP)
2023/10/07 21:27:31 INF [SRT] listener opened on :8890 (UDP)
```

# rtsp://localhost:8554/mystream

# http://localhost:8889/mystream

# mediamtx.yml
