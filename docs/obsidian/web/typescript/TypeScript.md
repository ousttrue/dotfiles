# vscode debugger

- [VS Codeで ts-nodeを使って TypeScriptをデバッグする方法 | ワルブリックス株式会社](https://www.walbrix.co.jp/article/debug-typescript-with-ts-node.html)

```js
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch TypeScript Using ts-node",
            "type": "node",
            "request": "launch",
            "skipFiles": [
                "<node_internals>/**",
                "node_modules/**"
            ],
            "runtimeArgs": [
                "--nolazy",
                "--loader",
                "ts-node/esm",
            ],
            "program": "${workspaceFolder}/index.ts",
            "args": [
            ]
        },
    ]
}
```

# Document

- [x] @2019 [思わずへ〜ってなったTypeScriptのトリビア10選 - dely Tech Blog](https://tech.dely.jp/entry/ten_trivia_of_typescript_)

## handbook

もっと信頼性が高い。これを見るべし
[TypeScript: Handbook - The TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)

## TypeScript Deep Dive

- [TypeScript Deep Dive 日本語版 - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/)

## サバイバルTypeScript

文章量と内容のバランスが悪いような
[TypeScript入門『サバイバルTypeScript』〜実務で使うなら最低限ここだけはおさえておきたいこと〜](https://typescriptbook.jp/)

# Version

## 5.2

- `using` [TypeScript: Documentation - TypeScript 5.2](https://www.typescriptlang.org/docs/handbook/release-notes/typescript-5-2.html)

## 4.9

- https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html

## 4.7

- Node.js ESM サポート

## 1.6

- @2015 [[JSX]]

# d.mts あかん

[\`\*.d.ts\` ファイルをコミットする前に知ってほしい4つのこと](<https://zenn.dev/qnighy/articles/9a6a0041f2a1aa#(1)-%E5%AE%9F%E3%81%AF-*.ts-%E3%81%A7%E3%81%84%E3%81%84%E3%81%8B%E3%82%82%E3%81%97%E3%82%8C%E3%81%AA%E3%81%84>)
=> `mts` に rename で `import some.mjs` で動く
=> `import type` いけるかも

# tsconfig.json

[tsconfig.jsonを設定する | TypeScript入門『サバイバルTypeScript』](https://typescriptbook.jp/reference/tsconfig/tsconfig.json-settings)

```json

```

# build

src => out へ

`tsconfig.json`

```json
  "references": [
    {
      "path": "./src/browser"
    }
  ]
```

```sh
> tsc -b ./tsconfig.all.json
```

=> `out/``
