/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"

	"github.com/charmbracelet/bubbles/list"
	"github.com/charmbracelet/bubbles/spinner"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
	"github.com/charmbracelet/log"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"github.com/tidwall/gjson"
)

const (
	AREA = "https://www.jma.go.jp/bosai/common/const/area.json"
)

var (
	titleStyle        = lipgloss.NewStyle().MarginLeft(2)
	itemStyle         = lipgloss.NewStyle().PaddingLeft(4)
	selectedItemStyle = lipgloss.NewStyle().PaddingLeft(2).Foreground(lipgloss.Color("170"))
	paginationStyle   = list.DefaultStyles().PaginationStyle.PaddingLeft(4)
	helpStyle         = list.DefaultStyles().HelpStyle.PaddingLeft(4).PaddingBottom(1)
	quitTextStyle     = lipgloss.NewStyle().Margin(1, 0, 2, 4)
)

// type item string
type item struct {
	code   string
	name   string
	parent string
}

func makeItem(code string, json gjson.Result) item {
	return item{
		code: code,
		name: json.Get("name").String(),
	}
}

func (i item) String() string {
	return fmt.Sprintf("[%s] %s", i.code, i.name)
}

func (i item) FilterValue() string { return i.name }

type itemDelegate struct{}

func (d itemDelegate) Height() int                             { return 1 }
func (d itemDelegate) Spacing() int                            { return 0 }
func (d itemDelegate) Update(_ tea.Msg, _ *list.Model) tea.Cmd { return nil }
func (d itemDelegate) Render(w io.Writer, m list.Model, index int, listItem list.Item) {
	i, ok := listItem.(item)
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

type areaCmd struct {
	areaJson string
}

//	{
//	  "column0": "010100",
//	  "name": "北海道地方",
//	  "enName": "Hokkaido",
//	  "officeName": "札幌管区気象台",
//	  "children":
//	  [
//	    "011000",
//	    "012000",
//	    "013000",
//	    "014030",
//	    "014100",
//	    "015000",
//	    "016000",
//	    "017000"
//	  ]
//	}
type center struct {
	code       string
	name       string
	enName     string
	officeName string
}

//	{
//	  "column0": "011000",
//	  "name": "宗谷地方",
//	  "enName": "Soya",
//	  "officeName": "稚内地方気象台",
//	  "parent": "010100",
//	  "children":
//	  [
//	    "011000"
//	  ]
//	}
type office struct {
	code       string
	name       string
	enName     string
	officeName string
	parent     string
}

//	{
//	  "column0": "011000",
//	  "name": "宗谷地方",
//	  "enName": "Soya Region",
//	  "parent": "011000",
//	  "children":
//	  [
//	    "011011",
//	    "011012",
//	    "011013"
//	  ]
//	}
type class10 struct {
	code   string
	name   string
	enName string
	parent string
}

//	{
//	  "column0": "011011",
//	  "name": "宗谷北部",
//	  "enName": "Northern Soya",
//	  "parent": "011000",
//	  "children":
//	  [
//	    "0121400",
//	    "0151100",
//	    "0151600",
//	    "0152000"
//	  ]
//	}
type class15 struct {
	name   string
	enName string
	parent string
}

//	{
//	  "column0": "0110000",
//	  "name": "札幌市",
//	  "enName": "Sapporo City",
//	  "kana": "さっぽろし",
//	  "parent": "016012"
//	}
type class20 struct {
	name   string
	enName string
	kana   string
	parent string
}

func makeList(json string, key string, parent string) list.Model {
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

// class20Model
type class20Model struct {
	list list.Model
	item item
}

func LoadClass20(json string, parent string) *class20Model {
	return &class20Model{
		list: makeList(json, "class20s", parent),
	}
}

func (m *class20Model) SetWidth(w int) {
	if len(m.list.Items()) > 0 {
		m.list.SetWidth(w)
	}
}

func (m *class20Model) Enter(json string) {
	if m.item.code == "" {
		i, ok := m.list.SelectedItem().(item)
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
	item    item
	class20 *class20Model
}

func LoadClass15(json string, parent string) *class15Model {
	return &class15Model{
		list: makeList(json, "class15s", parent),
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
		i, ok := m.list.SelectedItem().(item)
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
	item    item
	class15 *class15Model
}

func LoadClass10(json string, parent string) *class10Model {
	return &class10Model{
		list: makeList(json, "class10s", parent),
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
		i, ok := m.list.SelectedItem().(item)
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
	item    item
	class10 *class10Model
}

func LoadOffice(json string, parent string) *officeModel {
	return &officeModel{
		list: makeList(json, "offices", parent),
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
		i, ok := m.list.SelectedItem().(item)
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
	item   item
	office *officeModel
}

func LoadCenter(json string) *centerModel {
	return &centerModel{
		list: makeList(json, "centers", ""),
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
		i, ok := m.list.SelectedItem().(item)
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
	spinner  spinner.Model
	areaJson string
	center   *centerModel
}

func initModel() tea.Model {

	return &model{
		spinner: spinner.New(),
	}
}

func (m model) get() tea.Msg {
	res, err := http.Get(AREA)
	if err != nil {
		panic(err)
	}
	defer res.Body.Close()

	body, err := io.ReadAll(res.Body)
	if err != nil {
		panic(err)
	}

	return areaCmd{areaJson: string(body)}
}

func (m model) Init() tea.Cmd {
	return tea.Batch(
		m.get,
		m.spinner.Tick,
	)
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd
	m.spinner, cmd = m.spinner.Update(msg)

	switch msg := msg.(type) {
	case tea.WindowSizeMsg:
		if m.center != nil {
			m.center.SetWidth(msg.Width)
		}
		return m, cmd

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

	case areaCmd:
		m.areaJson = msg.areaJson
		m.center = LoadCenter(m.areaJson)
		return m, cmd
	}

	if m.center != nil {
		m.center.Update(msg)
	}

	return m, nil
}

func (m model) View() string {
	if m.areaJson == "" {
		return m.spinner.View()
	} else {
		return m.center.View()
	}
}

var cfgFile string

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "jma",
	Short: "天気予報",
	Long: `気象庁のJSON 情報を読み取る:
`,
	Run: func(cmd *cobra.Command, args []string) {
		prog := tea.NewProgram(initModel())
		err := prog.Start()
		if err != nil {
			log.Fatal(err)
		}
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)

	// Here you will define your flags and configuration settings.
	// Cobra supports persistent flags, which, if defined here,
	// will be global for your application.

	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jma.yaml)")

	// Cobra also supports local flags, which will only run
	// when this action is called directly.
	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := os.UserHomeDir()
		cobra.CheckErr(err)

		// Search config in home directory with name ".jma" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigType("yaml")
		viper.SetConfigName(".jma")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Fprintln(os.Stderr, "Using config file:", viper.ConfigFileUsed())
	}
}
