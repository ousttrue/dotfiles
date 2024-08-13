# Version

## 2.29

## 2.23

- @2020 [git switchとrestoreの役割と機能について #Git - Qiita](https://qiita.com/yukibear/items/4f88a5c0e4b1801ee952)

# repo

`repo.HEAD`

# local

## refs/heads/master

## refs/remotes/origin/master

```
remotes/origin/HEAD -> origin/master
```

# log

```
git log --oneline -n 1
git log --pretty=format:%s -n 1
```

# current branch

```
git branch --show-current
git branch --contains
```

# remote branch 整理

# tag create / push

# branch 選択

## switch

# commit 選択

## reset

# push / pull

- まだ push してない。
- remote の方が前

# gitconfig

## pager

- [How do I prevent 'git diff' from using a pager? - Stack Overflow](https://stackoverflow.com/questions/2183900/how-do-i-prevent-git-diff-from-using-a-pager)

# pull 時に fast-forward 強制

> github 上での merge 運用の場合など

```sh
git config pull.ff only
```
