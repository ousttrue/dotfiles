[[WebRTC]]
`Session Description Protocol`

browser では [[RTCPeerConnection]] が生成してくれる。
非ブラウザでは自前で作るかも。

# SessionDescription
[RFC 8866 - SDP: Session Description Protocol](https://tools.ietf.org/html/rfc8866)
`obsolete` [https://www.softfront.co.jp/tech/ietfdoc/trans/rfc4566j.txt](https://www.softfront.co.jp/tech/ietfdoc/trans/rfc4566j.txt)

- [シグナリング | 好奇心旺盛な人のためのWebRTC](https://webrtcforthecurious.com/ja/docs/02-signaling/)

RFC5761 RTP session

```sdp
v=0
o=- 2493253725758108504 2 IN IP4 127.0.0.1
s=-
t=0 0
a=group:BUNDLE 0
a=extmap-allow-mixed
a=msid-semantic: WMS
m=application 9 UDP/DTLS/SCTP webrtc-datachannel
c=IN IP4 0.0.0.0
a=candidate:1427578252 1 udp 2113937151 9e195c3b-05c6-45a4-821f-dc4dc4bfc132.local 56441 typ host generation 0 network-cost 999
a=ice-ufrag:GDdl
a=ice-pwd:TMoSMVu8LKem7TqaktF6LqUa
a=ice-options:trickle
a=fingerprint:sha-256 D6:08:AF:7A:52:59:69:00:B2:8C:06:20:9C:16:EB:9D:A0:80:6C:0B:29:EB:30:51:49:72:F1:9E:1B:BC:CF:E7
a=setup:actpass
a=mid:0
a=sctp-port:5000
a=max-message-size:262144
```

## Session
`最初にm行が出てくるまで`
   Session description
      v=  (protocol version)
      o=  (originator and session identifier)
      s=  (session name)
      i=* (session information)
      u=* (URI of description)
      e=* (email address)
      p=* (phone number)
      c=* (connection information -- not required if included in
           all media descriptions)
      b=* (zero or more bandwidth information lines)
      One or more time descriptions:
        ("t=", "r=" and "z=" lines; see below)
      k=* (obsolete)
      a=* (zero or more session attribute lines)
      Zero or more media descriptions

## Time
   Time description
      t=  (time the session is active)
      r=* (zero or more repeat times)
      z=* (optional time zone offset line)

## Media
`m から次の m もしくは最後まで`
   Media description, if present
      m=  (media name and transport address)
      i=* (media title)
      c=* (connection information -- optional if included at
           session level)
      b=* (zero or more bandwidth information lines)
      k=* (obsolete)
      a=* (zero or more media attribute lines)\

[[whip-whep]]
