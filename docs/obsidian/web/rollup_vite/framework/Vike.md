[Vike](https://vike.dev/)

- https://github.com/vikejs/vike

- @2023 [Vite + React で SSG する](https://kasyalog.site/blog/vite-react-ssg-with-vite-plugin-ssr/)
- [[Vite + React の SSR/SSG の基本的な動きを理解する - kasya blog](https://kasyalog.site/blog/vite-react-ssr-ssg-basic/)

- @2023 [vite-plugin-ssrの素振り - 🍊miyamonz🍊](https://scrapbox.io/miyamonz/vite-plugin-ssr%E3%81%AE%E7%B4%A0%E6%8C%AF%E3%82%8A)

- @2022 [Viteを使ってSSGを試した話 #AWS - Qiita](https://qiita.com/Kodak_tmo/items/23c0c334c6f08a4a036a)

# version

## v0.4.183

https://github.com/vikejs/vike/blob/main/CHANGELOG.md

## v0.4.142

`vite-plugin-ssr` から rename

# server & client

## vite dev

- vite(server) に アクセスして client(browser) で Rendering する？

## vite preview

?

## vite build

- vite(server) が rendering してファイルに出力する

# react-ts

```sh
> npm init vike@latest
```

`package.json`

```json
{
  "scripts": {
    "dev": "npm run server:dev",
    "prod": "npm run lint && npm run build && npm run server:prod",
    "build": "vite build",
    "server": "node --loader ts-node/esm ./server/index.ts",
    "server:dev": "npm run server",
    "server:prod": "cross-env NODE_ENV=production npm run server",
    "lint": "eslint . --max-warnings 0"
  },
  "dependencies": {
    "@types/compression": "^1.7.2",
    "@types/express": "^4.17.17",
    "@types/node": "^20.4.10",
    "@types/react": "^18.2.20",
    "@types/react-dom": "^18.2.7",
    "@typescript-eslint/eslint-plugin": "^6.3.0",
    "@typescript-eslint/parser": "^6.3.0",
    "@vitejs/plugin-react": "^4.0.4",
    "compression": "^1.7.4",
    "cross-env": "^7.0.3",
    "eslint": "^8.47.0",
    "eslint-plugin-react": "^7.33.1",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "express": "^4.18.2",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "sirv": "^2.0.3",
    "ts-node": "^10.9.1",
    "typescript": "^5.1.6",
    "vite": "^4.4.9",
    "vike": "^0.4.144"
  },
  "type": "module"
}
```

`tsconfig.json`

```json
{
  "compilerOptions": {
    "strict": true,
    "module": "ES2020",
    "target": "ES2020",
    // Doesn't apply to server/, see ts-node config down below and server/tsconfig.json
    "moduleResolution": "Bundler",
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "types": ["vite/client"],
    "jsx": "react-jsx",
    "skipLibCheck": true,
    "esModuleInterop": true
  },
  "ts-node": {
    "transpileOnly": true,
    "esm": true,
    "compilerOptions": {
      "module": "Node16",
      "moduleResolution": "Node16"
    }
  }
}
```

`vite.config.js`

```js
import react from '@vitejs/plugin-react'
import vike from 'vike/plugin'
import { UserConfig } from 'vite'

const config: UserConfig = {
  plugins: [react(), vike()]
}

export default config
```
