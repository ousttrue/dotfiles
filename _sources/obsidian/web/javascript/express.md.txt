[[vite]]

- [[typescript]] で開発
- [[front]] も vite 化 

# vite-node を使う
`ts-node` とどっちがよいか。
- [Scrapbox](https://scrapbox.io/dojineko/vite-node)

# express.static を vite で代替する
```ts

import * as vite from 'vite'

const app = express();
const server = http.createServer(app)

// 置き換える
// app.use(express.static(__dirname));

// express.static alternative
vite.createServer({
  root: __dirname,
  logLevel: 'info',
  server: {
    middlewareMode: true,
    watch: {
      usePolling: true,
      interval: 100,
    },
  },
}).then(viteServer => {
  app.use(viteServer.middlewares)
});
```

# socket.io を ws で置き換える
`typescript` と相性が悪い。特に `front`
`import` の vite で解決がよくわからんことに。

```
npm i -S ws
```

```ts
import WebSocket, { WebSocketServer } from 'ws';

const wss = new WebSocketServer({
});
```