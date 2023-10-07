[[streaming]]
[[gst_rtp_rtsp]]

[RTSP(Real Time Streaming Protocol)とは？ネットワークカメラに関する知識 - システムケイカメラ](https://systemk-camera.jp/camera-blog/knowledge/what-rtsp.php)

# RTSP
`TCP`
制御

# Server
## rtsp-simple-server
[[mediamtx]]


## ffserver
- [ffmpeg で RTSP MP4配信サーバー環境の構築](https://zenn.dev/pinto0309/scraps/33d7687dc8fbb1)

## OBS
- [obs-rtspserver/README_ja-JP.md at master · iamscottxu/obs-rtspserver · GitHub](https://github.com/iamscottxu/obs-rtspserver/blob/master/README_ja-JP.md)

## test-launch
`gst`
server/client 機能。publish は無い

## Kinesis Video Streams
配信サービス

# Publish
## gstreamer
`rtspclientsink`

## ffmpeg

# Client
## gstreamer
`rtspsrc`

## ffmpeg

# RTP
`UDP`
配信
