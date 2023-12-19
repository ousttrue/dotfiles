package tui

import (
	"fmt"
	"io"
	"strings"

	"github.com/charmbracelet/bubbles/list"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/tidwall/gjson"
)

// type item string
type ListItem struct {
	code   string
	name   string
	parent string
}

func makeItem(code string, json gjson.Result) ListItem {
	return ListItem{
		code: code,
		name: json.Get("name").String(),
	}
}

func (i ListItem) String() string {
	return fmt.Sprintf("[%s] %s", i.code, i.name)
}

func (i ListItem) FilterValue() string { return i.name }

type itemDelegate struct{}

func (d itemDelegate) Height() int                             { return 1 }
func (d itemDelegate) Spacing() int                            { return 0 }
func (d itemDelegate) Update(_ tea.Msg, _ *list.Model) tea.Cmd { return nil }
func (d itemDelegate) Render(w io.Writer, m list.Model, index int, listItem list.Item) {
	i, ok := listItem.(ListItem)
	if !ok {
		return
	}

	str := fmt.Sprintf("%d. %s", index+1, i)

	fn := itemStyle.Render
	if index == m.Index() {
		fn = func(s ...string) string {
			return selectedItemStyle.Render("> " + strings.Join(s, " "))
		}
	}

	fmt.Fprint(w, fn(str))
}

func MakeList(json string, key string, parent string) list.Model {
	items := []list.Item{}
	centers := gjson.Get(json, key).Map()
	for k, v := range centers {
		if parent == "" || v.Get("parent").String() == parent {
			items = append(items, makeItem(k, v))
		}
	}
	l := list.New(items, itemDelegate{}, 20, 14)
	l.Title = key
	l.SetShowStatusBar(false)
	l.SetFilteringEnabled(false)
	return l
}
