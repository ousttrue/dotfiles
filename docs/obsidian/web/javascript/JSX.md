[[React]]
`JavaScript Syntax Extension`

`v8` は解釈できないので、 `babel`, `tsc` などを使って `js` に変換する。
だったら、ついでに 型付の `tsx` でしょ。

[JSX を深く理解する – React](https://ja.legacy.reactjs.org/docs/jsx-in-depth.html)

- [JSX - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/tsx)
	- [JSX | TypeScript入門『サバイバルTypeScript』](https://typescriptbook.jp/reference/jsx)
	- [TypeScript: Documentation - JSX](https://www.typescriptlang.org/docs/handbook/jsx.html)

- @2023 [デザイナーが抱くReact+TypeScriptの疑問を紐解き、フロントエンドに一歩近づこう - estie inside blog](https://www.estie.jp/blog/entry/2023/04/10/123339)
- @2022 [JSXにいたる歴史と考察(2/2)](https://www.ey-office.com/blog_archive/2022/05/27/history-of-jsx-and-consideration-of-jsx-2/)

# as HtmlTemplate
- @2022 [ejs, pugやめてtsxでhtml書かね？ #React - Qiita](https://qiita.com/ment_RE/items/f9464b78e925e1db1d9b)
- @2021 [React をテンプレートエンジンの代わりに使う](https://zenn.dev/kazuma1989/articles/a5a824a7400921)
- @2020 [JSXが実はベターな解だったのではないか？｜erukiti](https://note.com/erukiti/n/n6f673021469e)
> HTMLとJSのどちらが制御構造を持てばいいのか？でいえばJS側が持つ方がリファクタリングしやすいため、JSXの方が良い
- @2020 [テンプレートエンジンに React を使いつつ、きれいな HTML を生成したいんじゃ！！](https://zenn.dev/otsukayuhi/articles/e52651b4e2c5ae7c4a17)

- [Cuttlebelle - The react static site generator that separates editing and code concerns](https://cuttlebelle.com/)

# JSX
## React(front)
[[React]]
## Next.js
[[Next.js]]
x
## Vue.js(front)
[[Vue.js]]

## Nuxt.js
## Gatsby
x
# root
```tsx
createRoot(globalThis.document.getElementById("root")!).render(
  <StrictMode>
    <App />
  </StrictMode>
)
```

# Component
```js
React.createElement(
  MyButton,
  {color: 'blue', shadowSize: 2},
  'Click Me'
)
```

```js
export default function Profile() {
  return (
    <img
      src="https://i.imgur.com/MK3eW3Am.jpg"
      alt="Katherine Johnson"
    />
  )
}
```

# type
- @2019 [TypeScriptの型におけるJSXサポートが100%分かる記事 #TypeScript - Qiita](https://qiita.com/uhyo/items/adf6cb83333a25097f25)
