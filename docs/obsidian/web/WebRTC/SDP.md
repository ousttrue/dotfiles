[[WebRTC]]
`Session Description Protocol`

[RFC 8866 - SDP: Session Description Protocol](https://tools.ietf.org/html/rfc8866)
[RFC 8829 - JavaScript Session Establishment Protocol (JSEP)](https://datatracker.ietf.org/doc/html/rfc8829)

# Protocol
- [WebRTCの簡易シグナリング - Qiita](https://qiita.com/massie_g/items/f5baf316652bbc6fcef1)
## offer
## answer

# Impl
## ayame
- [GitHub - OpenAyame/ayame: WebRTC Signaling Server Ayame](https://github.com/OpenAyame/ayame) 

# Create Signaling Server
- [自宅内でビデオ通信ができる「homelens」の開発録](https://zenn.dev/seita1996/articles/product-homelens)
## broadcast 無制限
[【WebRTC学習】③ シグナリングサーバを使ってP2Pを接続する - It’s now or never](https://inon29.hateblo.jp/entry/2020/02/09/124406)

# Session
> セッション記述部は「**一番最初にm行が出てくるまで**」

- v - バージョン(Version)、0 と同じでなければなりません。
- o - オリジン(Origin)、再交渉に便利なユニークな ID を含む。
- s - セッション名(Session Name)、- と同じでなければなりません。
- c - 接続データ(Connection Data)、 IN IP4 0.0.0.0 と等しくなければなりません。
- t - タイミング(Timing)、0 0 と同じでなければなりません。

## a=fingerprint

## a=msid-semantic

# Media



- m - メディア記述(Media Description: `m=<media> <port> <proto> <fmt> ...)、詳細は以下の通りです。`
- a - 属性(Attribute)、フリーテキストのフィールドです。これは WebRTC で最も一般的な行です。
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

