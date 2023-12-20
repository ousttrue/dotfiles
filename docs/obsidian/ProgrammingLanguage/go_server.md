[[golang]]

- dev
	backend: go server(air)
	- WebSocket
	frontend: vite
- production
	backend: go server
	- WebSocket
	- File.Server
	frontend: go server(static: dist <= vite build)

- `no docker` @2023 [Go(Gin)✖️React でAPIを呼び出し合う #React - Qiita](https://qiita.com/packmanrei/items/e5f3e56e9496b73f00a2)
		backend:8080 <=> frontend:vite:5173 proxy

vite.config.ts
```ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/ws': {
        target: 'ws://localhost:8080',
        ws: true,
      },
      "/api": {
        target: "http://localhost:8080", // <- to golang backend
        changeOrigin: true,
      },    }
  }
})
```

# air

```sh
> go install github.com/cosmtrek/air@latest
> air init
> air
```

# static
## http.FileServer

- `http.FileServer` @2020 [goでWebサービス No.3(静的ファイルの扱い)](https://zenn.dev/tomi/articles/2020-10-02-go-web3)
	- directory list あり
- `http.ServeFile` @2016 [net/httpで安全に静的ファイルを返す](https://shogo82148.github.io/blog/2016/04/13/serving-static-files-in-golang/)

### ContentType
- @2019 [Go言語のHTTPは勝手にContent-Typeを付与することがありそう](https://scrapbox.io/nwtgck/Go%E8%A8%80%E8%AA%9E%E3%81%AEHTTP%E3%81%AF%E5%8B%9D%E6%89%8B%E3%81%ABContent-Type%E3%82%92%E4%BB%98%E4%B8%8E%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8%E3%81%8C%E3%81%82%E3%82%8A%E3%81%9D%E3%81%86)

# websocket
- `not static host` `golang.org/x/net/websocket` @2021 [Go WebSocketを使ってみる #Go - Qiita](https://qiita.com/hiro_nico/items/db6cb98916fdf3e8c4cc)

# Docker
- `db` `docker` @2021 [Go言語で基本的なCRUD操作を行うREST APIを作成 | DevelopersIO](https://dev.classmethod.jp/articles/go-sample-rest-api/)

# back/server
## static
- @2023 [go-chiでAPI+Staticサーバーを作成する](https://zenn.dev/a10a/articles/963e5326523ff8)
- @2022 [Golang で HTTP サーバーを作成する (net/http, rs/cors) - まくまく Golang ノート](https://maku77.github.io/p/goruwy4/)
- [Goで簡単なwebサーバを立てる · Go Web 编程](https://docs.kilvn.com/build-web-application-with-golang/ja/03.2.html)

## https
- [net/httpでHTTPSサーバーを起動する | mokelab tech sheets](https://tech.mokelab.com/go/http/server/tls.html)

## air
- @2023 [【Go言語でホットリロード】AirとDockerによるAPI開発環境 | 株式会社ARISE analytics（アライズ アナリティクス）](https://www.ariseanalytics.com/activities/report/20230531/)

## gin
[Gin Web Framework](https://gin-gonic.com/ja/)
- @2021 [ginを最速でマスターしよう #Go - Qiita](https://qiita.com/Syoitu/items/8e7e3215fb7ac9dabc3a)


# front/client

## vite
- `docker-compose` `air` `api` `static` @2022 [ReactとGoで作るWebアプリの自分向けテンプレート - ゆるりと](https://khasegawa.hatenablog.com/entry/2022/03/08/001045)

- `docker-compose` @2023 [Docker + React + Go API 通信できる環境を構築する - りまねどっとねっと](https://rimane.net/docker-react-golang-api/)
- `docker-compose` @2022 [React + Golang + websocketでリアルタイムチャットアプリを作る -Part1/websocket編-](https://zenn.dev/tady/articles/adcdc65617ae57)

- `docker-compose` `mysql` @2022 [golang+reactなアプリの開発環境をモノレポで作る](https://zenn.dev/karabiner/articles/golang_react_monorepo)
- `docker-compose` `mysql` @2022 [GoでCRUD処理のREST APIを作ろう〜Reactを添えて〜 #React - Qiita](https://qiita.com/2san/items/dd2c6d0449262a42b728)
- `docker-compose` `mysql` [Go + MySQL + React のDocker開発環境を作成する #Docker - Qiita](https://qiita.com/makosinhori/items/c695774bef249a2014a6)

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
