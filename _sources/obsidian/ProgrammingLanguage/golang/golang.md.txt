[[nvim_golang]]
[[golang_tui]]

- [Go by Example](https://oohira.github.io/gobyexample-jp/)
- [つきなみGo 記事一覧 | gihyo.jp](https://gihyo.jp/list/group/%E3%81%A4%E3%81%8D%E3%81%AA%E3%81%BFGo#rt:/article/2022/08/tukinami-go-01)

# msys
- [MSYS2 環境に Go言語(golang) をインストール - takaya030の備忘録](https://takaya030.hatenablog.com/entry/2018/01/18/230105)
- [GOPATH set to GOROOT (C:\Go\) has no effectの対策方法 | Engineer Log](https://engineer-log.net/index.php/2016/11/25/gopath-set-to-goroot-cgo-has-no-effect/)
```
warning: GOPATH set to GOROOT (D:/msys64/mingw64/lib/go) has no effect
```

- [cmd/go: go mod download breaks on 1.21.0 due to empty GOPROXY · Issue #61928 · golang/go · GitHub](https://github.com/golang/go/issues/61928)
- [Goで使用する環境変数を表示・変更するgo envコマンド - CLOVER🍀](https://kazuhira-r.hatenablog.com/entry/2021/01/03/222459)
```
GOPROXY list is not the empty string, but contains no entries

go env -w GOPROXY=direct
```

[Go Modulesのproxyとsumdb - sambaiz-net](https://www.sambaiz.net/article/261/)
```
go env -w GOSUMDB=off
```

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
