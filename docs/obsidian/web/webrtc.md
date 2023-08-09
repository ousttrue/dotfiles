`Web Real-Time Communication`

- @2022 [WebRTC を今から学ぶ人に向けて](https://zenn.dev/voluntas/scraps/82b9e111f43ab3)
	- [はじめに | 好奇心旺盛な人のためのWebRTC](https://webrtcforthecurious.com/ja/)

# 実装
## Browser
```js
new RTCPeerConnection();
```

- @2023 [WebRTC を理解するためにカメラ映像を送るだけの最小実装を探る | blog.ojisan.io](https://blog.ojisan.io/webrtc-video-minimal-impl/)

### WebXR
- @2022 [WebRTC+WebXR でVRリモートデスクトップ - Qiita](https://qiita.com/binzume/items/52a4f4be5c316753e1b1)
- [2022-01 日記](https://www.binzume.net/diary/2022-01)
- [GitHub - binzume/webrtc-rdp: WebRTC + WebXR Remote Desktop](https://github.com/binzume/webrtc-rdp)

## Native
- [ブラウザ以外で WebRTC を利用する · GitHub](https://gist.github.com/voluntas/df61f8018c88b6490e18f2c3a3e8871d)

### libdatachannel
- [GitHub - paullouisageneau/libdatachannel: C/C++ WebRTC network library featuring Data Channels, Media Transport, and WebSockets](https://github.com/paullouisageneau/libdatachannel)
- @2023 [封装 libdatachannel Android 库 - Piasy的博客 | Piasy Blog](https://blog.piasy.com/2023/04/08/libdatachannel-native/index.html)
- @2023 [ローカルのネイティブアプリにWebRTCできるかNW.jsで実験](https://zenn.dev/okuoku/scraps/f5aa6b983d6e12)

### gstreamer
[[gst_webrtc]]

### libwebrtc
- [src - Git at Google](https://webrtc.googlesource.com/src)


- @2022 [WebRTC技術者（C++）必携リンク集 - Qiita](https://qiita.com/sdozono/items/57a9ec60072fdbea1f4c)
- @2022 [Windows C++ でWebRTCライブラリをビルドする際の注意点 - Qiita](https://qiita.com/sdozono/items/a06f19e6d1ffbdc9295a)
- @2022 [momoで使われているlibwebrtcのソースコードを見る](https://zenn.dev/tetsu_koba/articles/9bb8bc91d36561)
- @2019 [WebRTCの読み進め方 - yotiky Tech Blog](https://yotiky.hatenablog.com/entry/webrtc-howtoread)
- @2019 [WebRTC Native Client Momo の強さ. 色々な方が使ってくださっており、ありがとうございます。せっかくなのでどのへんが強… | by V | shiguredo | Medium](https://medium.com/shiguredo/webrtc-native-client-momo-%E3%81%AE%E5%BC%B7%E3%81%95-ccc631f34403)
- @2018 [ピュア WebRTC 実装. ピュアというのは libwebrtc… | by V | Medium](https://voluntas.medium.com/%E3%83%94%E3%83%A5%E3%82%A2-webrtc-%E5%AE%9F%E8%A3%85-51bbbec3be8e)
https://github.com/shiguredo/momo

- [Native WebRTCでも手動シグナリングがしたい! - Qiita](https://qiita.com/alivelime/items/e4bd386eb18160c7aeca)

## GStreamer
- [GStreamer で WebRTC を使用する](https://www.gclue.jp/2022/07/gstreamer-webrtc.html)

# WebRTC P2P
## SDP（Session Description Protocol）
[RFC 8866 - SDP: Session Description Protocol](https://tools.ietf.org/html/rfc8866)
[RFC 8829 - JavaScript Session Establishment Protocol (JSEP)](https://datatracker.ietf.org/doc/html/rfc8829)
- v - バージョン(Version)、0 と同じでなければなりません。
- o - オリジン(Origin)、再交渉に便利なユニークな ID を含む。
- s - セッション名(Session Name)、- と同じでなければなりません。
- t - タイミング(Timing)、0 0 と同じでなければなりません。
- m - メディア記述(Media Description: `m=<media> <port> <proto> <fmt> ...)、詳細は以下の通りです。`
- a - 属性(Attribute)、フリーテキストのフィールドです。これは WebRTC で最も一般的な行です。
- c - 接続データ(Connection Data)、 IN IP4 0.0.0.0 と等しくなければなりません。
```
v=0
o=- 0 0 IN IP4 127.0.0.1
s=-
c=IN IP4 127.0.0.1
t=0 0
m=audio 4000 RTP/AVP 111
a=rtpmap:111 OPUS/48000/2
m=video 4002 RTP/AVP 96
a=rtpmap:96 VP8/90000
```

# NAT トラバーサル
## `STUN (Session Traversal Utilities for NAT)`
[RFC 8489 - Session Traversal Utilities for NAT (STUN)](https://tools.ietf.org/html/rfc8489)
[RFC 5780 - NAT Behavior Discovery Using Session Traversal Utilities for NAT (STUN)](https://tools.ietf.org/html/rfc5780)

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
