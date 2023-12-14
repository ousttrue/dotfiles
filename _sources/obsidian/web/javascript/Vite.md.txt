[[vite_plugin_node]]
[[ModuleBundler]]

[特徴 | Vite](https://ja.vitejs.dev/guide/features.html)

- @2023 [Webpack から Vite に段階的に移行しました | PR TIMES 開発者ブログ](https://developers.prtimes.jp/2023/02/08/migrate-from-webpack-to-vite/)
- `PHP` @2022 [vite で最高の開発体験を手に入れる - pixiv inside](https://inside.pixiv.blog/2022/07/21/103000)

# Version
## 5

## 4

# setup
```
> npm create vite@latest

# or
> npm -D react react-dom @types/react @types/react-dom @vitejs/plugin-react
```

`vite.config.js`
```js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
})
```

`index.html`
```html
    <div id="root"></div>
    <script type="module" src="./main.tsx"></script>
```

`main.tsx`
```tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

`App.tsx`
```tsx
import React from 'react';

export default function App() {
  return (<></>)
}
```

# Typescript + React

- `vite@latest` @2023 [ViteでTypeScript×Reactの開発環境を構築してみた【前編】｜SHIFT Group 技術ブログ](https://note.com/shift_tech/n/n9c5fcd207680)
- `vite@latest` @2023 [viteでReact×TypeScript環境を爆速で作る最小版 #React - Qiita](https://qiita.com/teradonburi/items/fcdd900adb069811bfda)
- `vite@latest` `build.rollupOptions` @2023 [フロントエンドの開発環境にVite ＋ TypeScriptを導入する](https://designsupply-web.com/media/programming/7578/)
- `react` @2022 [Vite with TypeScript](https://www.robinwieruch.de/vite-typescript/)
- `vite@latest` @2022 [ViteでReact + TypeScript + TailwindCSSの環境構築をする](https://zenn.dev/sikkim/articles/93bf99d8588e68)
`> npm create vite@latest`
- `vue3` `vitejs@app` @2022 [ViteでVue3のTypescript環境を構築する | miyauci.me](https://miyauchi.dev/ja/posts/vite-vue3-typescript/)
- `vite` @2022 [Vite + React + TypeScript でプロジェクトを立ち上げる | For](https://for.kobayashiii.dev/articles/9jv5qclmgm7k)

