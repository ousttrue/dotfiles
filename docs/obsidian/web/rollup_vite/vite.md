https://ja.vitejs.dev/

```sh
npm create vite@latest ./
```

# 起動スクリプト

```ts
import { createServer } from "vite";
const viteServer = await createServer();
await viteServer.listen();
viteServer.printUrls();
```

# script tag や import 文を transpile する

```html
<script type="module" src="/src/main.ts"></script>
```

```js
import "hoge.ts";
```

素の状態では、Serer 処理は無い

# Version

## 6 @202412

- https://green.sapphi.red/blog/increasing-vites-potential-with-the-environment-api
- https://pre-vue-fes-2024-environment-api-slide.sapphi.red
- https://github.com/vitejs/vite/milestone/17
- [Environment API · vitejs/vite · Discussion #16358 · GitHub](https://github.com/vitejs/vite/discussions/16358)

## 5

- https://ja.vitejs.dev/guide/api-vite-runtime.html
- @2023 [Vite 5.0 is out! | Vite](https://vitejs.dev/blog/announcing-vite5?ref=storybookblog.ghost.io)

## 4

# use

vue ?

# backend 統合

- https://ja.vitejs.dev/guide/backend-integration.html

`node server.js` が起点になる。

## 切り分け

server が扱う url と、vite が server を経由せずに扱う url で切り分け。

### vite主: server.proxy

- [Vite で別のサーバーと一緒に動かしたいときは server.proxy オプションを使うメモ &#8211; 1ft-seabass.jp.MEMO](https://www.1ft-seabass.jp/memo/2024/04/06/vite-server-proxy-option-simple/)

## server.ts

- https://github.com/cyco130/vavite

- @2023 [viteでTypeScriptのバックエンド開発環境を動かす](https://zenn.dev/akinor1ty/articles/a17352d81b67b1)

- @2023 [Vite + React の SSR/SSG の基本的な動きを理解する - kasya blog](https://kasyalog.site/blog/vite-react-ssr-ssg-basic/)
- @2024 [Viteで作成したReactアプリをSSGで出力出来るように変更 #JavaScript - Qiita](https://qiita.com/otohusan/items/16f8d244859a1f1af46d)

### vite-node

```sh
vite-node --watch server.ts
```

## SSR server.ssrLoadModule

- https://vitejs.dev/guide/ssr
- @2023 [Viteでの開発中のSSR対応の仕組み | 東京工業大学デジタル創作同好会traP ](https://trap.jp/post/1863/)
