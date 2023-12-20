[[TERM/tui/bubbletea/lipgloss]]

# fullscreen
- [bubbletea/examples/altscreen-toggle at master · charmbracelet/bubbletea · GitHub](https://github.com/charmbracelet/bubbletea/tree/master/examples/altscreen-toggle)

# fullscreen initialize
- [bubbletea/examples/pager/main.go at master · charmbracelet/bubbletea · GitHub](https://github.com/charmbracelet/bubbletea/blob/master/examples/pager/main.go)

```go
import "github.com/charmbracelet/bubbles/viewport"
type model struct {
	viewport viewport.Model
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	case tea.WindowSizeMsg:
		headerHeight := lipgloss.Height(m.headerView())
		footerHeight := lipgloss.Height(m.footerView())
		verticalMarginHeight := headerHeight + footerHeight

		if !m.ready {
			// Since this program is using the full size of the viewport we
			// need to wait until we've received the window dimensions before
			// we can initialize the viewport. The initial dimensions come in
			// quickly, though asynchronously, which is why we wait for them
			// here.
			m.viewport = viewport.New(msg.Width, msg.Height-verticalMarginHeight)
			m.viewport.YPosition = headerHeight
			m.viewport.HighPerformanceRendering = useHighPerformanceRenderer
			m.viewport.SetContent(m.content)
			m.ready = true

			// This is only necessary for high performance rendering, which in
			// most cases you won't need.
			//
			// Render the viewport one line below the header.
			m.viewport.YPosition = headerHeight + 1
		} else {
			m.viewport.Width = msg.Width
			m.viewport.Height = msg.Height - verticalMarginHeight
		}

```

# View()

## split
# Style
[[TERM/tui/bubbletea/lipgloss]]
