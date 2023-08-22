package main

import (
	"fmt"

	"github.com/MakeNowJust/heredoc"
	"github.com/charmbracelet/glamour"
)

func main() {
	md := heredoc.Doc(`
      # Hello world
      text text text text

      - Item1
      - Item2
        - Item2-1
        - Item2-2
  `)

	out, err := glamour.Render(md, "dark")
	if err != nil {
		panic(err.Error())
	}

	fmt.Println(out)
}
