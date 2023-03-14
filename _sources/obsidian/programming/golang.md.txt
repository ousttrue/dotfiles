[[nvim_golang]]
[[golang_tui]]

- [つきなみGo 記事一覧 | gihyo.jp](https://gihyo.jp/list/group/%E3%81%A4%E3%81%8D%E3%81%AA%E3%81%BFGo#rt:/article/2022/08/tukinami-go-01)

# Version
## 1.20
## 1.19
@2022
- [これまでとこれからのGo | gihyo.jp](https://gihyo.jp/article/2022/08/tukinami-go-01)

## 1.16
`Go-Module` 推奨

`go get` の機能変更。`go install` が分離。
- @2022 [【Go】go getは不要？go installとは？](https://zenn.dev/tmk616/articles/383fc3fbb0ec4b)
- `go install`はバイナリ(ライブラリ)をインストール
- `go get`は`go.mod`を編集するだけ

`go mod tidy` で `go.mod` の編集はできる。

## 1.11
`Go-Module` 導入

## 1
@2012

# GOMODULE
- [Goのプロジェクト構成の基本](https://zenn.dev/nobonobo/articles/4fb018a24f9ee9)
- go.mod

```
> mkdir hello
> cd hello
hello> go mod init hello
hello> cat go.mod
module hello

go 1.18
```

## GOPATH
- [GOPATHを掃除してGo Modulesに移行しよう - KAYAC engineers' blog](https://techblog.kayac.com/migration-gopath-to-go-modules)

# tutorial
- [Goの初心者が見ると幸せになれる場所　#golang - Qiita](https://qiita.com/tenntenn/items/0e33a4959250d1a55045)
- [A Tour of Go](https://go.dev/tour/welcome/1)
- [Tutorial: Create a Go module - The Go Programming Language](https://go.dev/doc/tutorial/create-module)
