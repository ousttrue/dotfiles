[[vite]] [[rollup_plugin]]

[GitHub - vitejs/vite-plugin-react-pages: A vite framework for building react app. Especially suitable for document site and demos/playgrounds of react components.](https://github.com/vitejs/vite-plugin-react-pages)

[GitHub - hannoeru/vite-plugin-pages: File system based route generator for ⚡️Vite](https://github.com/hannoeru/vite-plugin-pages)

- [uzimaru's Blog](https://blog.uzimaru.com/entries/dirbase-route-for-vite.md)

[プラグイン API | Vite](https://ja.vitejs.dev/guide/api-plugin.html)

https://rollupjs.org/plugin-development/

- @2022 [Viteで従来型静的サイトの開発環境を構築するためにプラグインをたくさん作った #TypeScript - Qiita](https://qiita.com/macropygia/items/d37fd20a16fcef26914b)

- https://github.com/vitejs/vite-plugin-react-pages/issues/4

- https://mdxjs.com/packages/rollup/#mdxoptions

# copy

[Viteのvite-plugin-static-copyで特定のファイルをコピーする方法 | iwb.jp](https://iwb.jp/vite-plugin-static-copy-npm-run-build-config/)
# inline
`vite.config.js` に直接記述

# HMR

https://ja.vitejs.dev/guide/api-hmr.html

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
