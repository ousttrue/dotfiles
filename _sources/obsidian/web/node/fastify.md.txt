[[node.js]]

[Fast and low overhead web framework, for Node.js | Fastify](https://fastify.dev/)
- [[express]] の後継？
- [Fastify入門 - Wiblok](https://wiblok.com/ja/nodejs/fastify/)

- @2023 [fastifyに入門してみた](https://zenn.dev/joo_hashi/articles/0ebf7d1b2a1721)
- [Fastify入門としてJSON Schemaを使った検証を試してみた | DevelopersIO](https://dev.classmethod.jp/articles/fastify-json-schema-validation/)
- @2022 [今更ながらなんか速そうなfastify使ってみた #Node.js - Qiita](https://qiita.com/kerochelo/items/61e4858ec715692ed6e7)
- @2019 [Node.jsフレームワークを比較して見えたそれぞれの特徴 | MYTHRIL Inc.（ミスリル株式会社）](https://www.wantedly.com/companies/company_3239475/post_articles/179467)
- @2017 [FastifyをTypeScriptで利用する方法 #Node.js - Qiita](https://qiita.com/biga816/items/92d8537a34ebe0f70152)

# @fastify/vite
`typescript` できない？
[@fastify/vite | Fastify plugin for Vite integration](https://fastify-vite.dev/)
- @2022 [Building a Mini Next.js](https://hire.jonasgalvez.com.br/2022/may/18/building-a-mini-next-js/)
- @2022 [Fastify DX というフルスタックなフレームワークは伸びるか？](https://zenn.dev/acro5piano/articles/10a3977ca15822)
```sh
npm i fastify @fastify/vite react react-dom
npm i vite -D

npm create @vite/latest
npm i fastify @fastify/vite

├── server.js
├── client/
│    ├── base.jsx
│    ├── mount.js
│    └── index.html
├── vite.config.js
└── package.json
```
