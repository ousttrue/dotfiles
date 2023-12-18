[[nvim_golang]] [[golang_tui]] [[go_server]]

- [Go by Example](https://oohira.github.io/gobyexample-jp/)
- [つきなみGo 記事一覧 | gihyo.jp](https://gihyo.jp/list/group/%E3%81%A4%E3%81%8D%E3%81%AA%E3%81%BFGo#rt:/article/2022/08/tukinami-go-01)
- [Tutorials - The Go Programming Language](https://go.dev/doc/tutorial/)

# ToDo
- filer
- dap
- lsp
- browser
- dotmanager
- dock
	- test run
	- build run

# Version
## 1.21
@2023
- [Go 1.21連載始まります＆slogをどう使うべきか | フューチャー技術ブログ](https://future-architect.github.io/articles/20230731a/)
## 1.20
## 1.19
@2022
- [これまでとこれからのGo | gihyo.jp](https://gihyo.jp/article/2022/08/tukinami-go-01)
## 1.18
`workspace`

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
- [GOPATHを掃除してGo Modulesに移行しよう - KAYAC engineers' blog](https://techblog.kayac.com/migration-gopath-to-go-modules)

## project構成

- @2020 [あなたのGoアプリ/ライブラリのパッケージ構成もっとシンプルでよくない？ | フューチャー技術ブログ](https://future-architect.github.io/articles/20200528/)


## go mod init
- [Tutorial: Get started with Go - The Go Programming Language](https://go.dev/doc/tutorial/getting-started)
- @2023 [ちゃんと理解するGo言語開発環境構築：go mod initとその必要性 - Qiita](https://qiita.com/TakanoriVega/items/6d7210147c289b45298a)
- @2021 [go mod完全に理解した](https://zenn.dev/optimisuke/articles/105feac3f8e726830f8c)

```
$ go mod init hello
# go mod init github.com/ユーザー名/GoProject
go.mod
```

```go.mod
module hello

go 1.19
```

## workspace
- [Tutorial: Create a Go module - The Go Programming Language](https://go.dev/doc/tutorial/create-module)
- [Tutorial: Getting started with multi-module workspaces - The Go Programming Language](https://go.dev/doc/tutorial/workspaces)
- @2022 [go.workはmonorepoの夢を見るか - ぽよメモ](https://poyo.hatenablog.jp/entry/2022/12/05/090000)

```go.work
go 1.18

use ./hello
```

## 依存パッケージの追加
```
go get github.com/gin-gonic/gin
```


# tutorial
- [Goの初心者が見ると幸せになれる場所　#golang - Qiita](https://qiita.com/tenntenn/items/0e33a4959250d1a55045)
- [A Tour of Go](https://go.dev/tour/welcome/1)
- [Tutorial: Create a Go module - The Go Programming Language](https://go.dev/doc/tutorial/create-module)

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

# AST
- [Goの抽象構文木（AST）でBoilerplate Codeを自動生成する | メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/20221219-cf1e076c7c/)
- [go言語でASTの解析にgo/typesの機能を使うことの威力について - podhmo's diary](https://pod.hatenablog.com/entry/2018/04/08/204907)
- [GoのAST全部見る - ***の日記](https://monpoke1.hatenablog.com/entry/2018/12/16/110943)

# new
- [gonew を使って Go プロジェクトのテンプレートを活用する](https://zenn.dev/kou_pg_0131/articles/gonew-introduction)
