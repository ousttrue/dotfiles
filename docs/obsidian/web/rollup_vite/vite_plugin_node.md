[axe-me/vite-plugin-node](https://github.com/axe-me/vite-plugin-node)

- @2023 [viteでTypeScriptのバックエンド開発環境を動かす](https://zenn.dev/akinor1ty/articles/a17352d81b67b1)
- @2022 [How to set up Vite and Electron from scratch, with any frontend framework - DEV Community](https://dev.to/lucacicada/how-to-set-up-vite-and-electron-from-scratch-with-any-frontend-framework-40mb)
- [Viteを使ってExpress.jsアプリを作る](https://scrapbox.io/dojineko/Vite%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6Express.js%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B)

# Vue3
- [Vite+Vue3+Vuetify3+Expressのプロジェクトを1から作成する（ESLint、Prettier、Node.jsをPJに含めたモノレポ？構成） #JavaScript - Qiita](https://qiita.com/yuta-katayama-23/items/a40775326914ee9ed89a)

# express の static と組み合わせる
- @2022 [Viteをexpressにぶちこむ](https://zenn.dev/ddpn08/articles/ac30dae3e7c7ea)

うまくいかなかった(static の中にある ts を解決できない)。
代替案として、`app.use(express.static(DIR)))` の代わりに
`vite` を組み込む。

```js
import { createServer } from 'vite'

createServer({
  root: __dirname,
  logLevel: 'info',
  server: {
    middlewareMode: true,
    watch: {
      usePolling: true,
      interval: 100,
    },
  },
}).then(vite => {
  app.use(vite.middlewares)
});
```
