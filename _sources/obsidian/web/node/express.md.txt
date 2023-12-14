[[vite]]

要件: `https` + `front hosting(vite)` + `backend typescript(vite-node)`

- `server` を [[TypeScript]] 化
	- entry point の ts 化 => vite-node / ts-node
- `front` も [[TypeScript]] 化 
	- static を vite で host する => vite-middle ware

の両立

考え方はこれか
[GitHub - egoist/vite-plugin-mix: Adding backend API to your Vite app.](https://github.com/egoist/vite-plugin-mix)

`package.json`
```json
  "devDependencies": {
    "vite": "^5.0.8"
  },
  "dependencies": {
    "@types/express": "^4.17.21",
    "express": "^4.18.2"
  }
```

- @2023 [Express(Node.js)でTypeScript環境を構築するための完全ガイド | アールエフェクト](https://reffect.co.jp/node-js/express-typescript)

`app.ts`
```ts
import * as vite from 'vite'
import express from 'express';
import { fileURLToPath } from "node:url";
import path from "node:path";
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const port = 3000;

// static
const staticPath = path.join(__dirname, 'client')
if (import.meta.env.PROD) {
  app.use(express.static(staticPath))
}
else {
  // express.static alternative
  vite.createServer({
    root: staticPath,
    logLevel: 'info',
    server: {
      middlewareMode: true,
      watch: {
        usePolling: true,
        interval: 100,
      },
      // net::ERR_SSL_PROTOCOL_ERROR なおる？
	    hmr: {
	      protocol: "ws",
	    }

    },
  }).then(viteServer => {
    app.use(viteServer.middlewares)
  });
}

app.listen(port);
```

# server
## vite-plugin-node
- `vite` が server を起こす
- `vite` は base を host しない
`express.static` に vite を効かせる方法がわかない
- `use(express.static)` x
- `vite middleware` x
- @2021 [Viteを使ってExpress.jsアプリを作る - 🐾 Nekonote](https://scrapbox.io/dojineko/Vite%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6Express.js%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B)
- @2021 [Vite Plugin Node で Vite を Node.js Webアプリケーションの開発でも利用する - Webdelog](https://www.webdelog.info/entry/vite-plugin-node)

## ts-node
- `middleware` @2022 [Viteをexpressにぶちこむ](https://zenn.dev/ddpn08/articles/ac30dae3e7c7ea)
- `index.ts` @2023 [Express(Node.js)でTypeScript環境を構築するための完全ガイド | アールエフェクト](https://reffect.co.jp/node-js/express-typescript)
- `vite middleware` o
	
## vite-node
- [Scrapbox](https://scrapbox.io/dojineko/vite-node)
- `vite middleware` o

# front
## express.static を vite で代替する
```
npm i express @types/express
npm i @types/node
npm i vite
```

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
