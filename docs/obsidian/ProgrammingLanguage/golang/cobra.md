[[golang]]

[Cobra. Dev](https://cobra.dev/)
- [GitHub - spf13/cobra: A Commander for modern Go CLI interactions](https://github.com/spf13/cobra)

- @2022 [【Golang】1日でGoのcobraでサクッとCLIが作れちゃった話](https://zenn.dev/tama8021/articles/22_0627_go_cobra_cli)

# cli
`main.go`, `cmd/root.go` が上書きされる
```
$ go install github.com/spf13/cobra-cli@latest

$ cobra-cli init --license MIT --viper=false
```

# Cobra
`subcommand` parser. `subcommand` が想定されるので root command がある。

```go
package main

import (
    "fmt"
    "github.com/spf13/cobra"
    "os"
)

func main() {
    rootCmd := &cobra.Command{
        Use: "app",
        Run: func(c *cobra.Command, args []string) {
            fmt.Println("hello world")
        },
    }
    if err := rootCmd.Execute(); err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
}
```



# Viper
設定ファイル、環境変数。cobra と連動。

- @2023 [Go開発者への道 第4回 cobraとviperの使い方 | 成長したいエンジニアブログ](https://engineer-want-to-grow.com/go-column-no-4/)
- @2018 [逆引き cobra & viper - Qiita](https://qiita.com/nirasan/items/cc2ab5bc2889401fe596)
- `cobra init` @2018 [Go初心者がcobraを使ってコマンドラインツールを作ってみた話 - Adwaysエンジニアブログ](https://blog.engineer.adways.net/entry/advent_calendar_2018/18)
- @2018 [cobraとviperで設定ファイルの値をフラグの値で上書きする - 技術的なメモというか、忘却録](https://clavier.hatenablog.com/entry/2018/03/29/192240)

## flags
- [【Golang】cobraで作ったコマンドラインツール(CLI)にフラグを追加する - Simple minds think alike](https://simple-minds-think-alike.moritamorie.com/entry/add-flags-to-cobra-app)
