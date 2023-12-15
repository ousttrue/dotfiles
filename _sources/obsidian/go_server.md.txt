[[golang]]

- dev
	backend: go server
	frontend: vite
- production
	backend: go server
	backend: go server(static)

- @2023 [Go(Gin)✖️React でAPIを呼び出し合う #React - Qiita](https://qiita.com/packmanrei/items/e5f3e56e9496b73f00a2)

# Docker
- `db` `docker` @2021 [Go言語で基本的なCRUD操作を行うREST APIを作成 | DevelopersIO](https://dev.classmethod.jp/articles/go-sample-rest-api/)

# static
- @2023 [go-chiでAPI+Staticサーバーを作成する](https://zenn.dev/a10a/articles/963e5326523ff8)
- @2022 [Golang で HTTP サーバーを作成する (net/http, rs/cors) - まくまく Golang ノート](https://maku77.github.io/p/goruwy4/)
- [Goで簡単なwebサーバを立てる · Go Web 编程](https://docs.kilvn.com/build-web-application-with-golang/ja/03.2.html)

# https
- [net/httpでHTTPSサーバーを起動する | mokelab tech sheets](https://tech.mokelab.com/go/http/server/tls.html)

# vite
- `docker-compose` `separate-front` @2023 [Docker + React + Go API 通信できる環境を構築する - りまねどっとねっと](https://rimane.net/docker-react-golang-api/)
- `docker-compose` `separate-front` @2022 [React + Golang + websocketでリアルタイムチャットアプリを作る -Part1/websocket編-](https://zenn.dev/tady/articles/adcdc65617ae57)
- @2022 [ReactとGoで作るWebアプリの自分向けテンプレート - ゆるりと](https://khasegawa.hatenablog.com/entry/2022/03/08/001045)

```js
export default defineConfig({
  server: {
    host: '0.0.0.0',
    port: parseInt(process.env.PORT || '3000'),
    proxy:{
      '/api': {
        target: process.env.API_URL, // docker-compose.yamlで指定したURLに対してリクエストを投げさせる
        changeOrigin: true
      }
    }
  },
})
```
