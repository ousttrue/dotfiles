# API
[WebSocket - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/WebSocket)

```js
const ws = new WebSocket(url, protocols);


```


# client

```js
const protocol = (location.protocol === 'https:') ? 'wss://' : 'ws://';
const socketURL = protocol + location.hostname + ((location.port) ? (':' + location.port) : '') + '/terminals/';
```

# ws
[ws - npm](https://www.npmjs.com/package/ws)

- @2019 [WebSocket(ブラウザAPI)とws(Node.js) の基本、自分用のまとめ #JavaScript - Qiita](https://qiita.com/okumurakengo/items/c497fba7f16b41146d77)

## express-ws
[express-ws - npm](https://www.npmjs.com/package/express-ws)

- @2021 [ExpressでWebSocket通信を実施する。 #npm - Qiita](https://qiita.com/koji0705/items/cf16044c7d825d09d707)

### wss
- @2022 [express-wsで作ったWebsocet ServerをWSS化する話 | ともきの雑記ブログ](https://tomozakki.com/update-to-wss-use-express-ws-lib/)

# socket.io
`vite` と共存できぬ。`ws` に移行するべし。
