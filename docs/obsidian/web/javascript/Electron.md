- [クイック スタート | Electron](https://www.electronjs.org/ja/docs/latest/tutorial/quick-start)

- @2023 [Electronでリストランチャーアプリを作る - 倉下忠憲の発想工房](https://scrapbox.io/rashitamemo/Electron%E3%81%A7%E3%83%AA%E3%82%B9%E3%83%88%E3%83%A9%E3%83%B3%E3%83%81%E3%83%A3%E3%83%BC%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E3%82%8B)
- @2023 [Electron + Reactでデスクトップアプリを作ろう！ #React - Qiita](https://qiita.com/udayaan/items/2a7c8fd0771d4d995b69)
- @2022 [Electron Tips \~便利なモジュールや小技\~ #JavaScript - Qiita](https://qiita.com/shiro1212/items/1d30b583770fc16c22df)
- @2022 [【Electron】導入～ビルドまとめ - テク×てく ブログ](https://koubou-rei.com/entry/electron-create)
- @2021 [Electron入門 \~ Webの技術でつくるデスクトップアプリ](https://zenn.dev/sprout2000/books/6f6a0bf2fd301c)
- @2020 [OSSのJSONエディタをElectronアプリに移植した - マルシテイア](https://blog.amagi.dev/entry/json-editor-app)

# memo
- [Fuse.js | Fuse.js](https://www.fusejs.io/)
	- @2020 [How to Create a Fuzzy Search in React JS Using Fuse.JS | by Naveen DA | Analytics Vidhya | Medium](https://medium.com/analytics-vidhya/how-to-create-a-fuzzy-search-in-react-js-using-fuse-js-859f80345657)
	 - [React Fuzzy Searcher](https://goelhardik.github.io/react-fuzzy-searcher/)

# article
## electron-vite
名前被り
[Electron⚡️Vite | Electron⚡️Vite](https://electron-vite.github.io/)

```sh
> npm install -D vite vite-plugin-electron vite-plugin-electron-renderer
```

`package.json`
```json
{
  "main": "dist-electron/main.js",
}
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

## typescript
- `parcel` @2022 [【入門】ElectronをTypeScriptで手軽に試したい](https://zenn.dev/lowpaper/articles/89caa5cdddfd89)


# 構成

```sh
> npm install --save-dev electron

> npx electron main.js
```

## src/main/index.ts
`entry point`

```js
import { BrowserWindow, app, ipcMain, IpcMainInvokeEvent } from 'electron'
import path from "path";

// render の指定
const mainURL = `file://${__dirname}/render/index.html`

// or

// HMR for renderer base on electron-vite cli.
// Load the remote URL for development or the local html file for production.
if (is.dev && process.env['ELECTRON_RENDERER_URL']) {
	mainWindow.loadURL(process.env['ELECTRON_RENDERER_URL'])
} else {
	mainWindow.loadFile(join(__dirname, '../renderer/index.html'))
}
```

## src/renderer/index.html
`entry point` 内で指定する。
