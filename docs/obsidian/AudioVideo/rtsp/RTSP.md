[[streaming]]

`protocal概説` [RTSP(Real Time Streaming Protocol)とは？ネットワークカメラに関する知識 - システムケイカメラ](https://systemk-camera.jp/camera-blog/knowledge/what-rtsp.php)

# RTSP
`TCP` 制御
`UDP` Data

# Server
## rtsp-simple-server
[[mediamtx]]

## ffserver
- [ffmpeg で RTSP MP4配信サーバー環境の構築](https://zenn.dev/pinto0309/scraps/33d7687dc8fbb1)

## OBS
- [obs-rtspserver/README_ja-JP.md at master · iamscottxu/obs-rtspserver · GitHub](https://github.com/iamscottxu/obs-rtspserver/blob/master/README_ja-JP.md)

## test-launch
[[gst_rtp_rtsp]]
server/client 機能。publish は無い

## Kinesis Video Streams
配信サービス

# Client
`rtsp://host:8554/stream`

host に注意。正しい IP Address を指定するべし。
例えば、 WSL上のServerにWindowsからアクセスする場合は、`172.40.xx.xx` を使うべし。

[[gst_rtp_rtsp]]
[[ffmpeg]]
[[obs]]
[[vlc]]


# Publish
[[gst_rtp_rtsp]]
[[ffmpeg]]
