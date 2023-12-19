`chcp65001` しないとずれる。

- [GitHub - charmbracelet/bubbletea: A powerful little TUI framework 🏗](https://github.com/charmbracelet/bubbletea)
- @2023 [Bubble Tea | Alex Ho](https://alexho.dev/post/bubbletea/)
- @2022 [Rapidly building interactive CLIs in Go with Bubbletea - Inngest Blog](https://www.inngest.com/blog/interactive-clis-with-bubbletea)
- @2022  [Bubble Teaでマインスイーパー作った - forza alex](https://ybalexdp.hatenablog.com/entry/2022/07/24/181932)
- @2021 [Go bubbletea of a library every day - 深入理解Go - SegmentFault 思否](https://segmentfault.com/a/1190000040179971/en)
- @2022 [Bubble Tea でリッチなターミナルアプリケーションを作る #Go - 詩と創作・思索のひろば](https://motemen.hatenablog.com/entry/2022/06/introduction-to-go-bubbletea)
`spinner`, `list`, `tea.batch`
	- [GitHub - motemen/example-go-bubbletea](https://github.com/motemen/example-go-bubbletea/tree/main)
 
# Version
## 0.25
- @2023
## 0.24
- [v0.24.2](https://github.com/charmbracelet/bubbletea/releases/tag/v0.24.2)
## 0.22
- @2022 [Goメモ-242 (charmbracelet/bubbletea にマルチバイトサポートが入った)(v0.22.1) - いろいろ備忘録日記](https://devlights.hatenablog.com/entry/2022/08/24/073000)

# tutorial
- [x] https://github.com/charmbracelet/bubbletea/blob/master/README.md#tutorial
- [x] https://github.com/charmbracelet/bubbletea/blob/master/tutorials/commands/README.md
- [ ] @2022 [Charming Cobras with Bubbletea - Part 1](https://elewis.dev/charming-cobras-with-bubbletea-part-1)
[[cobra]]

# tea.Model
```go
// Model contains the program's state as well as it's core functions.
type Model interface {
	// Init is the first function that will be called. It returns an optional
	// initial command. To not perform an initial command return nil.
	Init() Cmd

	// Update is called when a message is received. Use it to inspect messages
	// and, in response, update the model and/or send a command.
	Update(Msg) (Model, Cmd)

	// View renders the program's UI, which is just a string. The view is
	// rendered after every Update.
	View() string
}
```

## Init

## Update

- tea.batch

## View

model を描画する(stringを返す)

```go
func (m model) View() string {
	return fmt.Sprintf("%s\n%s\n%s", 
		m.headerView(), 
		m.bodyView(), 
		m.footerView())
}
```


# Cmd
cmd と msg は pair。
Init か Update で cmd を発動し、Update で msg を反映する。

## fullscreen

```go
func main() {
	p := tea.NewProgram(model(5), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		log.Fatal(err)
	}
}
```

```go
func (m model) Init() tea.Cmd {
	return tea.Batch(tick(), tea.EnterAltScreen)
}
```

# Bubbles
- [GitHub - charmbracelet/bubbles: TUI components for Bubble Tea 🫧](https://github.com/charmbracelet/bubbles)

## Viewport
[[bubbletea_viewport]]

## list
## bubble-table
- [GitHub - Evertras/bubble-table: A customizable, interactive table component for the Bubble Tea framework](https://github.com/Evertras/bubble-table)

# LipGloss
[GitHub - charmbracelet/lipgloss: Style definitions for nice terminal layouts 👄](https://github.com/charmbracelet/lipgloss)
- @2021 [Go bubbletea of a library every day - 深入理解Go - SegmentFault 思否](https://segmentfault.com/a/1190000040179971/en)

```go
	return lipgloss.JoinVertical(lipgloss.Top,
		lipgloss.JoinHorizontal(lipgloss.Top, leftBox, rightBox),
		m.statusbar.View(),
	)
```

# markdown
- [GitHub - charmbracelet/glow: Render markdown on the CLI, with pizzazz! 💅🏻](https://github.com/charmbracelet/glow)
- @2022 [MarkdownとGlamourでGo製ツールの画面出力を色付かせる - はいばらのブログ](https://haibara-works.hatenablog.com/entry/2022/08/30/003033)

# github
GITHUB_OAUTH_TOKEN
- [GitHub - rubysolo/brows: CLI GitHub release browser](https://github.com/rubysolo/brows)
- [GitHub - caarlos0/fork-cleaner: Quickly clean up unused forks on your github account.](https://github.com/caarlos0/fork-cleaner)
- [GitHub - joaom00/gh-b: GitHub CLI extension to easily manage your branches](https://github.com/joaom00/gh-b)
- [GitHub - dlvhdr/gh-dash: A beautiful CLI dashboard for GitHub 🚀](https://github.com/dlvhdr/gh-dash)

# Apps
- [GitHub - antonmedv/walk: Terminal file manager](https://github.com/antonmedv/walk)
- [bubbletea · GitHub Topics · GitHub](https://github.com/topics/bubbletea)
- [GitHub - dlvhdr/gh-dash: A beautiful CLI dashboard for GitHub 🚀](https://github.com/dlvhdr/gh-dash)
- [GitHub - BOTbkcd/mayhem: A minimal TUI based task tracker 📝](https://github.com/BOTbkcd/mayhem)

## filer
- [GitHub - mistakenelf/fm: A terminal based file manager](https://github.com/mistakenelf/fm)
- [GitHub - nore-dev/fman: TUI File Manager](https://github.com/nore-dev/fman)
## pager?
- [GitHub - trashhalo/readcli: Tool that lets you read website content on the command line](https://github.com/trashhalo/readcli)

## fzf
- [Go の Fuzzy Finder ライブラリ「go-fzf」の紹介](https://zenn.dev/kou_pg_0131/articles/go-fzf-introduction)

# Log
- @2023 [Charm 製の Go ロギングライブラリ「Log」を試してみる](https://zenn.dev/kou_pg_0131/articles/charm-log-introduction)

# VHS
- [VHS でターミナルを録画する](https://zenn.dev/kou_pg_0131/articles/vhs-introduction)

# gum
- [gum を使ってシェルスクリプトの表示をカッコよくする](https://zenn.dev/kou_pg_0131/articles/gum-introduction)
- [gum/examples at main · charmbracelet/gum · GitHub](https://github.com/charmbracelet/gum/tree/main/examples)
