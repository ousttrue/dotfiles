package main

import (
	"fmt"
	"os"

	"monkey/repl"
)

func main() {
	// user, err := user.Current()
	// if err != nil {
	// 	panic(err)
	// }
	fmt.Printf("Hello! This is the Monkey programming language!\n")
	fmt.Printf("Feel free to type in commands\n")
	repl.Start(os.Stdin, os.Stdout)
}
