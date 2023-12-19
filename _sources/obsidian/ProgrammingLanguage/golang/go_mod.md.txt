
[[golang]]

`from 1.11`
`from 1.13 complete`
`from 1.16 default`

@2022 [[Go言語] ファイル分割とローカルパッケージ](https://zenn.dev/fm_radio/articles/ca2ff1dfcf89b5)

module => `go.mod` ファイル
package => `*.go` の `package HOGE` 宣言(directory名と同じにする)

# mod
## init
```
go mod init MODULE_NAME
```

## go.mod
- [go.modとgo.sumの読み方](https://zenn.dev/ryo_yamaoka/articles/595cf9e69229f9)

## go.sum
`go.mod` + `go mod tidy` => `go.sum`

# module の中にパッケージが含まれる
## package はフォルダー

- @2022 [goでディレクトリ名とpackage名が一致しないとき，importする側はどうなる？](https://zenn.dev/miyataka/scraps/849be35072822a)

## file分割
同一フォルダ内で同じ `package hoge`

## package分割


# multi
- @2020 [GoのMulti-module repositoryとバージョン管理 #Git - Qiita](https://qiita.com/takashabe/items/5ef6193a3f92411bf2c5)
