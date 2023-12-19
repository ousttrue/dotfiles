
[[golang]]

`from 1.11`
`from 1.13 complete`
`from 1.16 default`

# module の中にパッケージが含まれる
## package はフォルダー

- @2022 [goでディレクトリ名とpackage名が一致しないとき，importする側はどうなる？](https://zenn.dev/miyataka/scraps/849be35072822a)

# init
```
go mod init MODULE_NAME
```

# go.mod
- [go.modとgo.sumの読み方](https://zenn.dev/ryo_yamaoka/articles/595cf9e69229f9)

# go.sum
`go.mod` + `go mod tidy` => `go.sum`
