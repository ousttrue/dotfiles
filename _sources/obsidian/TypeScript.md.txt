# Version
## 5.2


## 4.9
- https://www.typescriptlang.org/docs/handbook/release-notes/typescript-4-9.html

## 4.7
- Node.js ESM サポート

# tsconfig.json
[tsconfig.jsonを設定する | TypeScript入門『サバイバルTypeScript』](https://typescriptbook.jp/reference/tsconfig/tsconfig.json-settings)

```json

```

# build

src => out へ

```tsconfig.json
  "references": [
    {
      "path": "./src/browser"
    }
  ]
```

```sh
> tsc -b ./tsconfig.all.json
```
