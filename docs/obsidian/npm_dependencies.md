[[npm]]

- @2021 [package.json に記述される チルダ ^ や キャレット \~ について](https://zenn.dev/ikuraikura/articles/d6ff3821017e29539a7a)

# 差し替え
- @2018 [npmライブラリをGitHubでFork・修正した自前バージョンに差し替えて使う | Qookie Tech](https://tech.qookie.jp/posts/use-npm-package-github-fork/)

# local
- @2019 [Githubまたはローカルのnpm のパッケージをinstallする方法 #GitHub - Qiita](https://qiita.com/pure-adachi/items/ba82b03dba3ebabc6312)
- @2016 [Github上にある最新のnpm packageをインストールする方法 #npm - Qiita](https://qiita.com/DQNEO/items/d166e25449124a3f2b4d)

# peerDependencies
- @2023 [npm v7以降のpeerDependencies採用方針 #Node.js - Qiita](https://qiita.com/masato_makino/items/dafb63982e6f20186122)

## histoire => vite

```json
{
  "peerDependencies": {
    "vite": "^2.9.0 || ^3.0.0 || ^4.0.0"
  }
}
```

## ignore

```npmrc
legacy-peer-deps=true
```
