
[「 Error: Cannot find module 'fs/promises' 」の対処法](https://zenn.dev/pontagon333/articles/425296e73487e2)

# version
## 20
## 12
## 10

# trouble
- [npm installでのCould not resolve dependencyエラーと--legacy-peer-depsについて](https://zenn.dev/minamiso/articles/78b22716f3338d)

# package.json
- @2019 [package.jsonにおけるdependenciesとdevDependenciesの違い(超シンプルに) - Qiita](https://qiita.com/fj_yohei/items/0b7fc2bc826df23935db)

## dependencies
> 実行において依存する

実行とは？`node XXX.js` のことぽい？
即ち server の依存。

```
npm install socket.io --save
```

## devDependencies
> テストやタスクランナー系

```
npm install socket.io --save-dev
```
