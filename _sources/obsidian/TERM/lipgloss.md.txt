
[GitHub - charmbracelet/lipgloss: Style definitions for nice terminal layouts 👄](https://github.com/charmbracelet/lipgloss)

- @2023 [リッチなターミナル描画を実現！ Lip Glossのススメ(ざっくりできること編)](https://zenn.dev/kurusugawa/articles/6cd32c4ab59d58)
- @2021 [Go bubbletea of a library every day - 深入理解Go - SegmentFault 思否](https://segmentfault.com/a/1190000040179971/en)

# style
`style.Render`

```go
docStyle = docStyle.MaxWidth(physicalWidth)
```

# layout
## 縦
lipgloss.JoinVertical
```go
	return lipgloss.JoinVertical(lipgloss.Top,
		lipgloss.JoinHorizontal(lipgloss.Top, leftBox, rightBox),
		m.statusbar.View(),
	)
```
## 横
lipgloss.JoinHorizontal
