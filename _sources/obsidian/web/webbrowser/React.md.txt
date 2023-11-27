[react.dev のご紹介 – React](https://ja.react.dev/blog/2023/03/16/introducing-react-dev)

# Version
- @2023 [React今昔物語 - ICS MEDIA](https://ics.media/entry/200310/)

## 18
- [How to Upgrade to React 18 – React](https://react.dev/blog/2022/03/08/react-18-upgrade-guide#updates-to-client-rendering-apis)
> ReactDOM.render is no longer supported in React 18

## 16.8
- Hooks 

# entry
```html
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
```

`main.tsx`
```tsx
import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/electron-vite.animate.svg'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div>
        <a href="https://electron-vite.github.io" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  )
}

export default App
```

# 関連

## JSX
[[JSX]]
- [JSX In Depth – React](https://legacy.reactjs.org/docs/jsx-in-depth.html)
- [JSX でマークアップを記述する – React](https://ja.react.dev/learn/writing-markup-with-jsx)

## TypeScript
[[TypeScript]]

React すなわち JSX であり、
JSX は transpile 必要。じゃぁ、ついでに TypeScript にしよう。となる

- `commonjs` `webpack` [React & TypeScriptのプロジェクト作成 - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/browser)
👇
`esm` `vite`

`package.json`
```json
{
  "type": "module",
}
```

`tsconfig.json`
```json
{
    "compilerOptions": {
        "esModuleInterop": true,
        "noEmit": true,
        "allowImportingTsExtensions": true,
        "jsx": "react"
    }
}
```

## React.FC(Function Component)
- [ReactでのTypeScript入門！環境構築から関数コンポーネントの活用まで│Muscle Coding](https://musclecoding.com/react-typescript/)

# 構成

## Vite + TypeScript + React
- @2023 [ViteでTypeScript×Reactの開発環境を構築してみた【前編】｜SHIFT Group 技術ブログ](https://note.com/shift_tech/n/n9c5fcd207680)

# hooks
- [ReactでrequestAnimationFrameを扱う](https://zenn.dev/yend724/articles/20211119-x1fph5dvdldsx4po)

# framework
## Next.js
[[Next.js]]

## ReactNative
- [React Native · Learn once, write anywhere](https://reactnative.dev/)

# error
## ERROR: Expected ">" but found "/"

## refers to a value, but is being used as a type here. Did you mean
