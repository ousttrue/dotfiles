
[lipgloss package - github.com/charmbracelet/lipgloss - Go Packages](https://pkg.go.dev/github.com/charmbracelet/lipgloss)

# Style
- https://zenn.dev/kou_pg_0131/articles/charm-log-introduction

```go
import "github.com/charmbracelet/lipgloss"

var style = lipgloss.NewStyle().
    Bold(true).
    Foreground(lipgloss.Color("#FAFAFA")).
    Background(lipgloss.Color("#7D56F4")).
    PaddingTop(2).
    PaddingLeft(4).
    Width(22)

fmt.Println(style.Render("Hello, kitty"))
```

## Log
- [Charm 製の Go ロギングライブラリ「Log」を試してみる](https://zenn.dev/kou_pg_0131/articles/charm-log-introduction)
