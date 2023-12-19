package tui

import (
	"log"

	"github.com/charmbracelet/bubbles/list"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

var (
	titleStyle        = lipgloss.NewStyle().MarginLeft(2)
	itemStyle         = lipgloss.NewStyle().PaddingLeft(4)
	selectedItemStyle = lipgloss.NewStyle().PaddingLeft(2).Foreground(lipgloss.Color("170"))
	paginationStyle   = list.DefaultStyles().PaginationStyle.PaddingLeft(4)
	helpStyle         = list.DefaultStyles().HelpStyle.PaddingLeft(4).PaddingBottom(1)
	quitTextStyle     = lipgloss.NewStyle().Margin(1, 0, 2, 4)
)

// class20Model
type class20Model struct {
	list list.Model
	item ListItem
}

func LoadClass20(json string, parent string) *class20Model {
	return &class20Model{
		list: MakeList(json, "class20s", parent),
	}
}

func (m *class20Model) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
	}
}

func (m *class20Model) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(ListItem)
		if ok {
			m.item = i
		}
	}
}

func (m *class20Model) Update(msg tea.Msg) {
	if m.item.code == "" {
		m.list, _ = m.list.Update(msg)
	}
}

func (m *class20Model) View() string {
	if m.item.code == "" {
		return m.list.View()
	} else {
		return m.item.String()
	}
}

// class15Model
type class15Model struct {
	list    list.Model
	item    ListItem
	class20 *class20Model
}

func LoadClass15(json string, parent string) *class15Model {
	return &class15Model{
		list: MakeList(json, "class15s", parent),
	}
}

func (m *class15Model) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
		m.class20.SetWidth(w)
	}
}

func (m *class15Model) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(ListItem)
		if ok {
			m.item = i
			m.class20 = LoadClass20(json, m.item.code)
		}
	} else {
		m.class20.Enter(json)
	}
}

func (m *class15Model) Update(msg tea.Msg) {
	if m.item.code == "" {
		m.list, _ = m.list.Update(msg)
	} else {
		m.class20.Update(msg)
	}
}

func (m *class15Model) View() string {
	if m.item.code == "" {
		return m.list.View()
	} else {
		return m.item.String() + "\n" + m.class20.View()
	}
}

// class10Model
type class10Model struct {
	list    list.Model
	item    ListItem
	class15 *class15Model
}

func LoadClass10(json string, parent string) *class10Model {
	return &class10Model{
		list: MakeList(json, "class10s", parent),
	}
}

func (m *class10Model) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
		m.class15.SetWidth(w)
	}
}
func (m *class10Model) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(ListItem)
		if ok {
			m.item = i
			m.class15 = LoadClass15(json, m.item.code)
		}
	} else {
		m.class15.Enter(json)
	}
}

func (m *class10Model) Update(msg tea.Msg) {
	if m.item.code == "" {
		m.list, _ = m.list.Update(msg)
	} else {
		m.class15.Update(msg)
	}
}

func (m *class10Model) View() string {
	if m.item.code == "" {
		return m.list.View()
	} else {
		return m.item.String() + "\n" + m.class15.View()
	}
}

// officeModel
type officeModel struct {
	list    list.Model
	item    ListItem
	class10 *class10Model
}

func LoadOffice(json string, parent string) *officeModel {
	return &officeModel{
		list: MakeList(json, "offices", parent),
	}
}

func (m *officeModel) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
		m.class10.SetWidth(w)
	}
}

func (m *officeModel) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(ListItem)
		if ok {
			m.item = i
			m.class10 = LoadClass10(json, m.item.code)
		}
	} else {
		m.class10.Enter(json)
	}
}

func (m *officeModel) Update(msg tea.Msg) {
	if m.item.code == "" {
		m.list, _ = m.list.Update(msg)
	} else {
		m.class10.Update(msg)
	}
}

func (m *officeModel) View() string {
	if m.item.code == "" {
		return m.list.View()
	} else {
		return m.item.String() + "\n" + m.class10.View()
	}
}

// centerModel
type centerModel struct {
	list   list.Model
	item   ListItem
	office *officeModel
}

func LoadCenter(json string) *centerModel {
	return &centerModel{
		list: MakeList(json, "centers", ""),
	}
}

func (m *centerModel) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
		m.office.SetWidth(w)
	}
}

func (m *centerModel) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(ListItem)
		if ok {
			m.item = i
			m.office = LoadOffice(json, m.item.code)
		}
	} else {
		m.office.Enter(json)
	}
}

func (m *centerModel) Update(msg tea.Msg) {
	if m.item.code == "" {
		m.list, _ = m.list.Update(msg)
	} else {
		m.office.Update(msg)
	}
}

func (m *centerModel) View() string {
	if m.item.code == "" {
		return m.list.View()
	} else {
		return m.item.String() + "\n" + m.office.View()
	}
}

// centers
// offices
// class10s
// class15s
// class20s
type model struct {
	areaJson string
	center   *centerModel
}

func (m model) Init() tea.Cmd {
	return GetArea(m)
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {

	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		if m.center != nil {
			m.center.SetWidth(msg.Width)
		}
		return m, nil

	case tea.KeyMsg:
		switch msg.String() {
		case "q", "ctrl+c":
			return m, tea.Quit

		case "enter":
			if m.center != nil {
				m.center.Enter(m.areaJson)
			}
			return m, nil
		}

	case AreaMsg:
		m.areaJson = msg.areaJson
		m.center = LoadCenter(m.areaJson)
		return m, nil
	}

	if m.center != nil {
		m.center.Update(msg)
	}

	return m, nil
}

func (m model) View() string {
	if m.areaJson == "" {
		return ""
	} else {
		return m.center.View()
	}
}

func Run() {
	prog := tea.NewProgram(&model{})
	_, err := prog.Run()
	if err != nil {
		log.Fatal(err)
	}
}
