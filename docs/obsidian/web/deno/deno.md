[[v8]] [[deno_nvim]]

- [Denoで自分用Dotfilesマネージャーを作ってみた](https://zenn.dev/kato_k/articles/06ab404938f896)
- [Denoでdotfilesを書く - くたくたじゅうよん](https://scrapbox.io/takker/Deno%E3%81%A7dotfiles%E3%82%92%E6%9B%B8%E3%81%8F)
- [Deno+daxでDotfilesのセットアップ用CLIツールを整備する](https://zenn.dev/3w36zj6/articles/074d432c0bcc5c)

[Deno Runtime Quick Start | Deno Docs](https://docs.deno.com/runtime/manual)

- [Deno by Example](https://examples.deno.land/)
  [Effective Deno](https://zenn.dev/uki00a/books/effective-deno)
  [週刊Deno](https://uki00a.github.io/deno-weekly/)

- @2023 [Denoのフロントエンド開発の動向【2023年夏】](https://zenn.dev/uki00a/articles/frontend-development-in-deno-2023-summer)
- @2022 [Deno を始める 第1回：開発環境とランタイム | 豆蔵デベロッパーサイト](https://developer.mamezou-tech.com/deno/getting-started/01-introduction/)

# Version

## 1.45

https://deno.com/blog/v1.45

## 1.37

## 1.31

`ffi` breaking change !
https://deno.com/blog/v1.31#breaking-change-in-ffi-api

## 1.25

- [Deno を始める 第1回：開発環境とランタイム | 豆蔵デベロッパーサイト](https://developer.mamezou-tech.com/deno/getting-started/01-introduction/)
- `deno init`
- FFI: typedarray `poiner` => `buffer`
- [Deno 1.25 Release Notes](https://deno.com/blog/v1.25)

## 1.24

Deno 1.24 you can use Deno.UnsafePointer.of:

## 1.6.0

@2020 [Deno v1.6.0で実装された新機能の紹介 - Qiita](https://qiita.com/uki00a/items/86eae971286d2bff515a)
`deno compile` `deno lsp`

## 1.0

@202005

# lsp

[neovim lsp でdenolsとtsserverを自動で切り替える](https://zenn.dev/mochi/articles/e6b2735108157c)

# debugger

[マニュアル | Deno](https://deno-ja.vercel.app/manual@v1.6.1/getting_started/debugging_your_code#vscode)

# FFI

[[deno_ffi]]

# websocket

- @2022 [DenoのWebSocketサーバーの書き方 2022冬編 #JavaScript - Qiita](https://qiita.com/access3151fq/items/7e2bdbd8f24858cf1f49)
- [WebSocket サーバーを JavaScript (Deno) で書く - Web API | MDN](https://developer.mozilla.org/ja/docs/Web/API/WebSockets_API/Writing_a_WebSocket_server_in_JavaScript_Deno)

## https

```js
let listener = Deno.listenTls({
  port: 80,
  certFile: "証明書ファイルパス",
  keyFile: "秘密鍵ファイルパス",
});
```

## pty

[deno_pty_ffi@0.16.0 | Deno](https://deno.land/x/deno_pty_ffi@0.16.0)

# WebRTC

- [GitHub - oslabs-beta/sono.land: Real-time Communication Library for Deno (WebSockets & WebRTC)](https://github.com/oslabs-beta/sono.land)

# OpenGL

[[deno_opengl]]

- [GitHub - deno-windowing/gluten: OpenGL bindings & WebGL API implementation for Deno.](https://github.com/deno-windowing/gluten)

# Web

## fresh

[GitHub - denoland/fresh: The next-gen web framework.](https://github.com/denoland/fresh)

## aleph.js

- [GitHub - alephjs/aleph.js: The Full-stack Framework in Deno.](https://github.com/alephjs/aleph.js)

## lume

- [Lume, the static site generator for Deno - Lume](https://lume.land/)
- [Deno製の静的サイトジェネレータ "Lume" の紹介](https://zenn.dev/fabon/articles/b388c84320a2f8)

# shell

- [GitHub - dsherret/dax: Cross platform shell tools for Deno inspired by zx.](https://github.com/dsherret/dax)
