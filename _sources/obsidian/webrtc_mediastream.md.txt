[[WebRTC]]

[MediaStream - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/MediaStream)

# MediaStream
- @2017 [JavaScriptでWebRTCやるための基礎知識 - console.lealog();](https://lealog.hateblo.jp/entry/2017/06/05/102203)
```js
navigator.mediaDevices.getUserMedia() // パソコンのカメラやマイクから
$canvas.captureStream() // canvas要素から
($audio|$video).captureStream() // 将来的にはaudio要素やvideo要素からも
```

```js
const $video = document.createElement('video');
$video.autoPlay = true;

// 自身のストリーム or
// なんらかの手段で取得したP2P相手のストリーム
$video.srcObject = stream;
// or
$video.src = URL.createObjectURL(stream);
```

# MediaStreamTrack

# protocol
[[streaming]]
## rtp

## rtsp
- [GitHub - medooze/rtsp-client: RTSP signaling only client library](https://github.com/medooze/rtsp-client)
- [GitHub - Ullaakut/WebRTCCTV: WebRTCCTV is a signaling server & webapp able to stream from RTSP cameras using WebRTC](https://github.com/Ullaakut/WebRTCCTV)

# codec
## h264
## vp9

