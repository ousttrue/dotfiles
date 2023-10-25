- [TypeScript Deep Dive 日本語版 - TypeScript Deep Dive 日本語版](https://typescript-jp.gitbook.io/deep-dive/)
- [TypeScript入門『サバイバルTypeScript』〜実務で使うなら最低限ここだけはおさえておきたいこと〜](https://typescriptbook.jp/)

# Version
## 5.2


## 4.9
- https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html

## 4.7
- Node.js ESM サポート

## 1.6
- @2015 [[JSX]]

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

