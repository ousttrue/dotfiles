[[WebRTC]]

[PeerJS - Simple peer-to-peer with WebRTC](https://peerjs.com/)
- [GitHub - peers/peerjs: Simple peer-to-peer with WebRTC](https://github.com/peers/peerjs)

[Building an Internet-Connected Phone with PeerJS - Web APIs | MDN](https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Build_a_phone_with_peerjs)
- [PeerJS によるインターネット接続電話の構築 - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/WebRTC_API/Build_a_phone_with_peerjs)

# Version
## 1.5.1
- @2023

## 古
- @2018 [PeerJSを今後も使い続けるのは危険. 2023.11.21 追記 | by Yusuke Naka | Medium](https://medium.com/@Tukimikage/peerjs%E3%82%92%E4%BB%8A%E5%BE%8C%E3%82%82%E4%BD%BF%E3%81%84%E7%B6%9A%E3%81%91%E3%82%8B%E3%81%AE%E3%81%AF%E5%8D%B1%E9%99%BA-8c3cf68d56a0)
- @2014 [WebRTC開発者向けライブラリ「PeerJS」はこうして作られた | HTML5Experts.jp](https://html5experts.jp/yusuke-naka/3693/)

# server
[GitHub - peers/peerjs-server: Server for PeerJS](https://github.com/peers/peerjs-server)
```sh
> npm install peer -g
```

```js
const { PeerServer } = require("peer");

const peerServer = PeerServer({ port: 9000, path: "/myapp" });
```

# nodertc
- @2018 [NodeJS製WebRTC DataChannel、NodeRTCのコードを読む Part.1 | Memory ice cubes](https://leaysgur.github.io/posts/2018/11/26/174220/)
