`chcp65001` しないとずれる。

- [bubbletea/tutorials at master · charmbracelet/bubbletea · GitHub](https://github.com/charmbracelet/bubbletea/tree/master/tutorials)

# Version
## 0.24
- [v0.24.2](https://github.com/charmbracelet/bubbletea/releases/tag/v0.24.2)
## 0.22
- @2022 [Goメモ-242 (charmbracelet/bubbletea にマルチバイトサポートが入った)(v0.22.1) - いろいろ備忘録日記](https://devlights.hatenablog.com/entry/2022/08/24/073000)

# Basic
## mainloop
```go
// start main loop
    p := tea.NewProgram(m)
    if err := p.Start(); err != nil {
        fmt.Printf("app-name: %s", err.Error())
        os.Exit(1)
    }
```

## view
```go
func (m model) View() string 
{
}
```
### fmt.Sprintf
- @2022  [Bubble Teaでマインスイーパー作った - forza alex](https://ybalexdp.hatenablog.com/entry/2022/07/24/181932)
- @2020 [【Go言語】ElmArchitectureでTUIアプリが作れるbubbleteaでちょっとリッチなToDoアプリを作る](https://zenn.dev/yuzuy/articles/95e522a39a5423f5bff4)

# View
- @2022 [Bubble Tea でリッチなターミナルアプリケーションを作る #Go - 詩と創作・思索のひろば](https://motemen.hatenablog.com/entry/2022/06/introduction-to-go-bubbletea)
`spinner`, `list`
	- [GitHub - motemen/example-go-bubbletea](https://github.com/motemen/example-go-bubbletea/tree/main)

## bubble-table
- [GitHub - Evertras/bubble-table: A customizable, interactive table component for the Bubble Tea framework](https://github.com/Evertras/bubble-table)

# LipGloss
- @2021 [Go bubbletea of a library every day - 深入理解Go - SegmentFault 思否](https://segmentfault.com/a/1190000040179971/en)

# markdown
- [GitHub - charmbracelet/glow: Render markdown on the CLI, with pizzazz! 💅🏻](https://github.com/charmbracelet/glow)
- @2022 [MarkdownとGlamourでGo製ツールの画面出力を色付かせる - はいばらのブログ](https://haibara-works.hatenablog.com/entry/2022/08/30/003033)

# Apps
- [GitHub - antonmedv/walk: Terminal file manager](https://github.com/antonmedv/walk)
- [bubbletea · GitHub Topics · GitHub](https://github.com/topics/bubbletea)
- [GitHub - dlvhdr/gh-dash: A beautiful CLI dashboard for GitHub 🚀](https://github.com/dlvhdr/gh-dash)

## filer
- [GitHub - mistakenelf/fm: A terminal based file manager](https://github.com/mistakenelf/fm)
- [GitHub - nore-dev/fman: TUI File Manager](https://github.com/nore-dev/fman)
## pager?
- [GitHub - trashhalo/readcli: Tool that lets you read website content on the command line](https://github.com/trashhalo/readcli)

## fzf
- [Go の Fuzzy Finder ライブラリ「go-fzf」の紹介](https://zenn.dev/kou_pg_0131/articles/go-fzf-introduction)

# examples
- [bubbletea/examples at master · charmbracelet/bubbletea · GitHub](https://github.com/charmbracelet/bubbletea/tree/master/examples)

# Cobra
- [Charming Cobras with Bubbletea - Part 1](https://elewis.dev/charming-cobras-with-bubbletea-part-1)

# Lipgross

# Log
- @2023 [Charm 製の Go ロギングライブラリ「Log」を試してみる](https://zenn.dev/kou_pg_0131/articles/charm-log-introduction)

# VHS
- [VHS でターミナルを録画する](https://zenn.dev/kou_pg_0131/articles/vhs-introduction)


