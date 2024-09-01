- [プラグイン API | Vite](https://ja.vitejs.dev/guide/api-plugin.html)
- https://rollupjs.org/plugin-development/

# 自作

- @2022 [Viteで従来型静的サイトの開発環境を構築するためにプラグインをたくさん作った #TypeScript - Qiita](https://qiita.com/macropygia/items/d37fd20a16fcef26914b)
- [Viteで使うRollupプラグインの作り方と便利に使っている自作プラグインの解説 #vite - Qiita](https://qiita.com/NanimonoDaemon/items/26e075d20451bd2a00ae)

## inline

`vite.config.js` に直接記述

```ts vite.config.ts
import { defineConfig, Plugin } from "vite";

// https://vitejs.dev/config/
const config = defineConfig({
  plugins: [pluginDevelop()],
});

function pluginDevelop(): Plugin {
  return {
    name: "mydev-vite-plugin",
  };
}

export default config;
```

# middleware

自前の js(ts) をエントリーポイントにした方がデバッガをアタッチできる。

# impl

- [GitHub - hannoeru/vite-plugin-pages: File system based route generator for ⚡️Vite](https://github.com/hannoeru/vite-plugin-pages)
- [[vite_plugin_node]]
- [GitHub - vitejs/vite-plugin-react-pages: A vite framework for building react app. Especially suitable for document site and demos/playgrounds of react components.](https://github.com/vitejs/vite-plugin-react-pages)

## hannoeru/vite-plugin-pages

- [uzimaru's Blog](https://blog.uzimaru.com/entries/dirbase-route-for-vite.md)

## copy

[Viteのvite-plugin-static-copyで特定のファイルをコピーする方法 | iwb.jp](https://iwb.jp/vite-plugin-static-copy-npm-run-build-config/)
