- [クイック スタート | Electron](https://www.electronjs.org/ja/docs/latest/tutorial/quick-start)

- @2023 [Electronでリストランチャーアプリを作る - 倉下忠憲の発想工房](https://scrapbox.io/rashitamemo/Electron%E3%81%A7%E3%83%AA%E3%82%B9%E3%83%88%E3%83%A9%E3%83%B3%E3%83%81%E3%83%A3%E3%83%BC%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B)
- @2023 [Electron + Reactでデスクトップアプリを作ろう！ #React - Qiita](https://qiita.com/udayaan/items/2a7c8fd0771d4d995b69)
- @2022 [Electron Tips \~便利なモジュールや小技\~ #JavaScript - Qiita](https://qiita.com/shiro1212/items/1d30b583770fc16c22df)
- @2022 [【Electron】導入～ビルドまとめ - テク×てく ブログ](https://koubou-rei.com/entry/electron-create)
- @2021 [Electron入門 \~ Webの技術でつくるデスクトップアプリ](https://zenn.dev/sprout2000/books/6f6a0bf2fd301c)
- @2020 [OSSのJSONエディタをElectronアプリに移植した - マルシテイア](https://blog.amagi.dev/entry/json-editor-app)
- `parcel` @2022 [【入門】ElectronをTypeScriptで手軽に試したい](https://zenn.dev/lowpaper/articles/89caa5cdddfd89)

# 構成 
## electron-vite
名前被り。これ使うべし
`vite` `electron` `typescript` `react`

[Electron⚡️Vite | Electron⚡️Vite](https://electron-vite.github.io/)

```sh
# start(vite + react + typescript + electron)
> npm create electron-vite@latest

# append
> npm i -D @types/node
```

`package.json`
```json
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.21",
    "@types/react-dom": "^18.2.7",
    "@typescript-eslint/eslint-plugin": "^6.6.0",
    "@typescript-eslint/parser": "^6.6.0",
    "@vitejs/plugin-react": "^4.0.4",
    "eslint": "^8.48.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "typescript": "^5.2.2",
    "vite": "^4.4.9",
    "electron": "^26.1.0",
    "electron-builder": "^24.6.4",
    "vite-plugin-electron": "^0.14.0",
    "vite-plugin-electron-renderer": "^0.14.5"
  },
  "main": "dist-electron/main.js"
```

`vite.config.js`
```js
import { defineConfig } from 'vite'
import path from 'node:path'
import electron from 'vite-plugin-electron/simple'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    electron({
      main: {
        // Shortcut of `build.lib.entry`.
        entry: 'main.ts',  // => dist-electron/main.js
      },
      preload: {
        // Shortcut of `build.rollupOptions.input`.
        // Preload scripts may contain Web assets, so use the `build.rollupOptions.input` instead `build.lib.entry`.
        input: path.join(__dirname, 'preload.ts' 
        // => dist-electron/preload.js
        ),
      },
      // Ployfill the Electron and Node.js built-in modules for Renderer process.
      // See 👉 https://github.com/electron-vite/vite-plugin-electron-renderer
      renderer: {},
    }),
  ],
})
```

`load` 
```js
const VITE_DEV_SERVER_URL = process.env['VITE_DEV_SERVER_URL']

if (VITE_DEV_SERVER_URL) {
	window.loadURL(VITE_DEV_SERVER_URL)
} else {
	// window.loadFile('dist/index.html')
	window.loadFile(path.join(process.env.DIST, 'index.html'))
}
```

## electron-vite
名前被り
使い方がわからんかった。
[electron-vite | Next Generation Electron Build Tooling](https://evite.netlify.app/)
- @2023 [electron-vite で Electron アプリ開発の生産性を上げる | 豆蔵デベロッパーサイト](https://developer.mamezou-tech.com/blogs/2023/05/22/electron-vite/)

## vue
- @2022 [vite(+vue)+electronでアプリをビルドする #Vue.js - Qiita](https://qiita.com/Quantum/items/00fe28792bb869aa4f65)

# devtool

# memo
- [Fuse.js | Fuse.js](https://www.fusejs.io/)
	- @2020 [How to Create a Fuzzy Search in React JS Using Fuse.JS | by Naveen DA | Analytics Vidhya | Medium](https://medium.com/analytics-vidhya/how-to-create-a-fuzzy-search-in-react-js-using-fuse-js-859f80345657)
	 - [React Fuzzy Searcher](https://goelhardik.github.io/react-fuzzy-searcher/)

# server 兼用
Electron が WebServer を兼ねる
- [[object Object]: Site Unreachable](https://kent-and-co.com/881/)
- [Electronでアプリ内部にWebサーバーを立てる #JavaScript - Qiita](https://qiita.com/pman-taichi/items/406b6eb068e074dc6675)
- [同一アプリをWeb版とElectron版の両方で作る方法 - Taste of Tech Topics](https://acro-engineer.hatenablog.com/entry/2018/12/24/215009)

# 内部を独自プロトコル
- [Electron 上で Next.js などの Web フレームワークを使いたい](https://zenn.dev/rithmety/articles/20220412-web-server-on-electron-b9dda210d3c3f4)
- [electron-server - npm](https://www.npmjs.com/package/electron-server)
