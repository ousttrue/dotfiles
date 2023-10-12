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

# WebSocket
- [WebSocket 経由のシグナリング](https://sora-doc.shiguredo.jp/SIGNALING)

# STUN(nat越え)

