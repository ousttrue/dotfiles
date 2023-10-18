# 仕様的に ssl が必要なところ
## device へのアクセス
- webcam => [[WebRTC]]
- vr機器 => [[webxr]]

## https からの websocket(wss) ?
よくわからん。不明

# local
- @2022 [ローカル環境でもHTTPS接続する理由と方法 | フロントエンドBlog | ミツエーリンクス](https://www.mitsue.co.jp/knowledge/blog/frontend/202208/30_1021.html)

# host

## node: http-server
- [http-serverによるローカル HTTPS server 構築 (5分でできる) - Qiita](https://qiita.com/hbjpn/items/925c8012cd93d9165be6)

```sh
> mkcert localhost 127.0.0.1 192.168.11.2 # 👈 複数指定できる
> http-server -c-1 . --ssl --key localhost-key.pem --cert localhost.pem
```

# HTTPSリバースproxy
## node: local-ssl-proxy
- @2023 [LOCAL環境でHTTPSが必要なときはlocal-ssl-proxyが便利 - Qiita](https://qiita.com/cress_cc/items/ba3d7112d36035f88749)
- [[小ネタ]local-ssl-proxyを利用したNext.js開発環境のHTTPSアクセスを簡単にしてみた | DevelopersIO](https://dev.classmethod.jp/articles/tried-local-ssl-proxy-x-nextjs/)

```sh
npx local-ssl-proxy --source 8082 --target 8081
```

# 独自CA証明書
- @2021 [localhost を https 化する ~独自CA証明書を作って~](https://zenn.dev/jeffi7/articles/10f7b12d6044ad)

## mkcert
`golang` [[aqua]]  で入れるとよい
