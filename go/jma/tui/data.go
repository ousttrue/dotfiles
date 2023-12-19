package tui

import (
	"io"
	"net/http"

	tea "github.com/charmbracelet/bubbletea"
)

const (
	AREA = "https://www.jma.go.jp/bosai/common/const/area.json"
)

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

type AreaMsg struct {
	areaJson string
}

func GetArea(m model) tea.Cmd {

	return func() tea.Msg {
		res, err := http.Get(AREA)
		if err != nil {
			panic(err)
		}
		defer res.Body.Close()

		body, err := io.ReadAll(res.Body)
		if err != nil {
			panic(err)
		}

		return AreaMsg{areaJson: string(body)}
	}
}
