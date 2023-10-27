[[gatsby]]

[react.dev のご紹介 – React](https://ja.react.dev/blog/2023/03/16/introducing-react-dev)

- [React – ユーザインターフェース構築のための JavaScript ライブラリ](https://ja.reactjs.org/)
- [実装に関するメモ – React](https://ja.reactjs.org/docs/implementation-notes.html)

- [Reactをはじめる - ウェブ開発を学ぶ | MDN](https://developer.mozilla.org/ja/docs/Learn/Tools_and_testing/Client-side_JavaScript_frameworks/React_getting_started)

- @2023 [React今昔物語 - ICS MEDIA](https://ics.media/entry/200310/)

# Version
## 18
- [How to Upgrade to React 18 – React](https://react.dev/blog/2022/03/08/react-18-upgrade-guide#updates-to-client-rendering-apis)
> ReactDOM.render is no longer supported in React 18

## 16
- Hooks 

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

# framework
## Next.js

## ReactNative
- [React Native · Learn once, write anywhere](https://reactnative.dev/)

# error
## ERROR: Expected ">" but found "/"

## refers to a value, but is being used as a type here. Did you mean
