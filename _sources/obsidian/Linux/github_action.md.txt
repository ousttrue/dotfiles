[[Linux]]

- @2022 [GitHub Actions のベストプラクティス](https://zenn.dev/snowcait/scraps/9d9c47dc4d0414)

# sample
- [入門 GitHub Actions（Pythonライブラリ・Lint・テスト・PyPIアップロード・バッジ設定） - Qiita](https://qiita.com/simonritchie/items/629a02fc1ad0fd02d267)
- [GitHub Actionsを使ってsetup.cfgをもとに_version.pyを更新する - Qiita](https://qiita.com/gyu-don/items/c047098e1a58dc8d8d96)
- @2020 [Github Actionsでビルドしてリリースにアップロードしてみた - 二度忘れた事を三度忘れないようにする](https://knhk.hatenablog.com/entry/2020/05/19/173000)

# runner
- [About GitHub-hosted runners - GitHub Docs](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
```yml
jobs:
  Run-npm-on-Ubuntu:
    name: Run npm on Ubuntu
    runs-on: ubuntu-latest
```

## ubuntu
- [GitHub Actions: Ubuntu 22.04 is now generally available on GitHub-hosted runners | GitHub Changelog](https://github.blog/changelog/2022-08-09-github-actions-ubuntu-22-04-is-now-generally-available-on-github-hosted-runners/)
- `ubuntu-latest`

## windows
- `windows-latest`

`vcvars64.bat`
- [Meson with MSVC on GitHub Actions](https://dvdhrm.github.io/2021/04/21/meson-msvc-github-actions/)

## matrix
- [Using a matrix for your jobs - GitHub Docs](https://docs.github.com/en/actions/using-jobs/using-a-matrix-for-your-jobs)
- @2020 [GitHub Actionsを使ったパッケージ作成の自動化 - 2020-01-23 - ククログ](https://www.clear-code.com/blog/2020/1/23.html)

# docker
[[docker]]
- [【GitHub Actions】Dockerコンテナを実行してみた - Qiita](https://qiita.com/suzuki0430/items/d625f8b57ae317ae7d66)

# action
## docker
- [Creating a Docker container action - GitHub Docs](https://docs.github.com/en/actions/creating-actions/creating-a-docker-container-action)
