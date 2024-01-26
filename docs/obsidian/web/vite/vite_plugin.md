[[vite]] [[rollup_plugin]]

[プラグイン API | Vite](https://ja.vitejs.dev/guide/api-plugin.html)

https://rollupjs.org/plugin-development/

- @2022 [Viteで従来型静的サイトの開発環境を構築するためにプラグインをたくさん作った #TypeScript - Qiita](https://qiita.com/macropygia/items/d37fd20a16fcef26914b)

# inline
`vite.config.js` に直接記述

# order

- エイリアス
- `enforce: 'pre'` を指定したユーザープラグイン
- Vite のコアプラグイン
- enforce の値がないユーザープラグイン
- Vite のビルドプラグイン
- `enforce: 'post'` を指定したユーザープラグイン
- Vite ポストビルドプラグイン (minify, manifest, reporting)

# plugin

## name: string
## enforce: 'pre' | 'post'
## apply: 'serve' | 'build'


# rollup hook
[[rollup_plugin]]


# vite hook

## config
`before config`

## async configResolved(config)
`after config`

## configureServer(server)
`dev server`

## configurePreviewServer
`preview server`

## transformIndexHtml

## handleHotUpdate


# impl
[[vite_plugin_node]]
