[[golang]]

- [Cobra. Dev](https://cobra.dev/)

- [GitHub - spf13/cobra: A Commander for modern Go CLI interactions](https://github.com/spf13/cobra)
- @2022 [【Golang】1日でGoのcobraでサクッとCLIが作れちゃった話](https://zenn.dev/tama8021/articles/22_0627_go_cobra_cli)

# flags
- [【Golang】cobraで作ったコマンドラインツール(CLI)にフラグを追加する - Simple minds think alike](https://simple-minds-think-alike.moritamorie.com/entry/add-flags-to-cobra-app)

# cobra-cli init
`main.go`, `cmd/root.go` が上書きされる
```
$ go install github.com/spf13/cobra-cli@latest

$ cobra-cli init --license MIT --viper=false
```

# viper
- [逆引き cobra & viper - Qiita](https://qiita.com/nirasan/items/cc2ab5bc2889401fe596)
- [Go初心者がcobraを使ってコマンドラインツールを作ってみた話 - Adwaysエンジニアブログ](https://blog.engineer.adways.net/entry/advent_calendar_2018/18)
- [cobraとviperで設定ファイルの値をフラグの値で上書きする - 技術的なメモというか、忘却録](https://clavier.hatenablog.com/entry/2018/03/29/192240)


