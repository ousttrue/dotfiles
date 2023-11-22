難易度的に次の順に実験するとよい
- 手動 datachannel(sdp と iceCandidate をまとめてコピペする)
- websocket datachannel(sdp と iceCandidate を別々に送る)
- https + websocket datachannel
- https + websocket mediachannel
- https + websocket mediachannel + stan (NAT越え。必要であれば)

media (webcam) へのアクセスに https が要求されるため、
- https + 手動 mediachannel
から始めることになり、これはわりと手順が長くなる。
あと、datachannel の方が `sdp` が短いのでログ表示が怖くならない。

# vanilla
- @2017 [WebRTCの簡易シグナリング - Qiita](https://qiita.com/massie_g/items/f5baf316652bbc6fcef1)

# trickle


# 手動

- [copy-paste](https://github.com/paullouisageneau/libdatachannel/tree/master/examples/copy-paste)

```js
// local from sessionDesc
const peer = new RTCPeerConnection();
const dc = peer.createDataChannel("test-data-channel", dataChannelOptions);
const sessionDescription = await peer.createOffer();
await peer.setLocalDescription(sessionDescription);
peer.onicecandidate = (_) => {
	const offer = peer.localDescription.sdp
}

// remote from offer
const peer = new RTCPeerConnection();
await peer.setRemoteDescription(offer);
const sessionDescription = await peer.createAnswer();
await peer.setLocalDescription(sessionDescription);
peer.onicecandidate = (_) => {
	const answer = peer.localDescription.sdp
}

// accept
await peer.setRemoteDescription(answer);
dc.send(msg);
dc.onmessage = (evt) => {
	const msg = evt.data;
};
```

# WHIP/WHEP
[[whip-whep]]

# WebSocket
	- @2020 [【WebRTC学習】③ シグナリングサーバを使ってP2Pを接続する - It’s now or never](https://inon29.hateblo.jp/entry/2020/02/09/124406)
- [3-signaling-server](https://github.com/morooka-akira/webrtc-study/tree/master/examples/3-signaling-server)

https://gist.github.com/hugosp/5eeb2a375157625e21d33d75d10574df

# STUN(nat越え)


# ayame
- [GitHub - OpenAyame/ayame: WebRTC Signaling Server Ayame](https://github.com/OpenAyame/ayame) 