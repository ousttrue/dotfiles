https://ja.vite.dev/guide/ssr.html

# react

https://github.com/bluwy/create-vite-extra/tree/master/template-ssr-react

- index.html
- src/
  - main.js # exports env-agnostic (universal) app code
  - entry-client.js # mounts the app to a DOM element
  - entry-server.js # renders the app using the framework's SSR API

`index.html`

```html
<div id="app"><!--ssr-outlet--></div>
<script type="module" src="/src/entry-client.js"></script>
```

# hydrate 重要

`import 'hoge.css';` に必要だった。

- [renderToStringとhydrateを作って学ぶReactのSSR・SSG](https://zenn.dev/did0es/articles/b41d0de60934cc)

# hydrate 無しで css を動作させる

inline と style tag でできる。

```tsx
import styles from './App.css?inline'

<style>{styles}</style>
```
