`Web Real-Time Communication`

[[WebRTC_signaling]]
[[SDP]]

- [WebRTC API - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/WebRTC_API)
	- [はじめに | 好奇心旺盛な人のためのWebRTC](https://webrtcforthecurious.com/ja/)
	- @2022 [WebRTC を今から学ぶ人に向けて](https://zenn.dev/voluntas/scraps/82b9e111f43ab3)

# topology
- [WebRTCのリアルタイム音声合成サーバ(MCU)を作ってみた](https://zenn.dev/shinyoshiaki/articles/webrtc-mcu-example)

## video server
- `docker` [GitHub - ossrs/srs: SRS is a simple, high-efficiency, real-time video server supporting RTMP, WebRTC, HLS, HTTP-FLV, SRT, MPEG-DASH, and GB28181.](https://github.com/ossrs/srs)
- [[mediamtx]]

## P2P
```js
new RTCPeerConnection();
```
- @2019 [addTransceiver() と addTrack() の使い分け | Memory ice cubes](https://leaysgur.github.io/posts/2019/03/12/114529/)

- `manual` @2016 [手動でWebRTCの通信をつなげよう ーWebRTC入門2016 | HTML5Experts.jp](https://html5experts.jp/mganeko/19814/)
- `websocket` @2023 [WebRTCを利用した複数人でのビデオ通話サンプル(Mesh) - Qiita](https://qiita.com/nakka_/items/2d1fd3a941f7c0c1108f)
- `websocket` @2022  [自宅内でビデオ通信ができる「homelens」の開発録](https://zenn.dev/seita1996/articles/product-homelens)
- @2023 [WebRTC を理解するためにカメラ映像を送るだけの最小実装を探る | blog.ojisan.io](https://blog.ojisan.io/webrtc-video-minimal-impl/)

## SFU
- [[pion]]
- [[Janus]]
- [[mediasoup]]

### WebXR
- @2022 [WebRTC+WebXR でVRリモートデスクトップ - Qiita](https://qiita.com/binzume/items/52a4f4be5c316753e1b1)
- @2022 [2022-01 日記](https://www.binzume.net/diary/2022-01)
- [GitHub - binzume/webrtc-rdp: WebRTC + WebXR Remote Desktop](https://github.com/binzume/webrtc-rdp)

## js
- [[werift]]
- [[PeerJS]]

## py
- [aiortc — aiortc documentation](https://aiortc.readthedocs.io/en/latest/index.html)


## csharp


## Native
- [ブラウザ以外で WebRTC を利用する · GitHub](https://gist.github.com/voluntas/df61f8018c88b6490e18f2c3a3e8871d)

### libdatachannel
- [GitHub - paullouisageneau/libdatachannel: C/C++ WebRTC network library featuring Data Channels, Media Transport, and WebSockets](https://github.com/paullouisageneau/libdatachannel)
- @2023 [封装 libdatachannel Android 库 - Piasy的博客 | Piasy Blog](https://blog.piasy.com/2023/04/08/libdatachannel-native/index.html)
- @2023 [ローカルのネイティブアプリにWebRTCできるかNW.jsで実験](https://zenn.dev/okuoku/scraps/f5aa6b983d6e12)

### gstreamer
`gst => signaling => browser`
[[gst_webrtc]]

### libwebrtc
> ビルド大変？

- [src - Git at Google](https://webrtc.googlesource.com/src)

- @2022 [WebRTC技術者（C++）必携リンク集 - Qiita](https://qiita.com/sdozono/items/57a9ec60072fdbea1f4c)
- @2022 [Windows C++ でWebRTCライブラリをビルドする際の注意点 - Qiita](https://qiita.com/sdozono/items/a06f19e6d1ffbdc9295a)
- @2022 [momoで使われているlibwebrtcのソースコードを見る](https://zenn.dev/tetsu_koba/articles/9bb8bc91d36561)
- @2019 [WebRTCの読み進め方 - yotiky Tech Blog](https://yotiky.hatenablog.com/entry/webrtc-howtoread)
- @2019 [WebRTC Native Client Momo の強さ. 色々な方が使ってくださっており、ありがとうございます。せっかくなのでどのへんが強… | by V | shiguredo | Medium](https://medium.com/shiguredo/webrtc-native-client-momo-%E3%81%AE%E5%BC%B7%E3%81%95-ccc631f34403)
- @2018 [ピュア WebRTC 実装. ピュアというのは libwebrtc… | by V | Medium](https://voluntas.medium.com/%E3%83%94%E3%83%A5%E3%82%A2-webrtc-%E5%AE%9F%E8%A3%85-51bbbec3be8e)
https://github.com/shiguredo/momo
- @2017 [Native WebRTCでも手動シグナリングがしたい! - Qiita](https://qiita.com/alivelime/items/e4bd386eb18160c7aeca)

# NAT トラバーサル
## `STUN (Session Traversal Utilities for NAT)`
[RFC 8489 - Session Traversal Utilities for NAT (STUN)](https://tools.ietf.org/html/rfc8489)
[RFC 5780 - NAT Behavior Discovery Using Session Traversal Utilities for NAT (STUN)](https://tools.ietf.org/html/rfc5780)
### google
```js
const senderConnection = new RTCPeerConnection({
  iceServers: [
    {
      urls: "stun:stun.l.google.com:19302",
    },
  ],
});
```

## TURN(Traversal Using Relays around NAT)
[RFC 8656 - Traversal Using Relays around NAT (TURN): Relay Extensions to Session Traversal Utilities for NAT (STUN)](https://tools.ietf.org/html/rfc8656)

## STUN/TURN サーバー
### coturn
- [GitHub - coturn/coturn: coturn TURN server project](https://github.com/coturn/coturn)
- [WebRTC で利用されいる TURN プロトコルの解説 · GitHub](https://gist.github.com/voluntas/a1d39c2b2a4392956ff69732dc493e39)

# mDNS
[[mDNS]]
`UUID`

# ICE（Interactive Connectivity Establishment）
[RFC 4787 - Network Address Translation (NAT) Behavioral Requirements for Unicast UDP](https://tools.ietf.org/html/rfc4787)
[RFC 8445 - Interactive Connectivity Establishment (ICE): A Protocol for Network Address Translator (NAT) Traversal](https://tools.ietf.org/html/rfc8445)

# Transport
## DTLS
DTLS（Datagram Transport Layer Security）
## SRTP
SRTP（Secure Real-time Transport Protocol）

https://dslab.work/2019/04/25/post-119/

# Qt
- [j0r1's page | Misc/QtWebRTC](https://research.edm.uhasselt.be/jori/page/Misc/QtWebRTC.html)
