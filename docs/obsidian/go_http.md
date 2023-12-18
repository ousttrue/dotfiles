[[go_server]]

- @2021 [Deep Dive into The Go's Web Server](https://zenn.dev/hsaki/books/golang-httpserver-internal)
- @2020 [ginを最速でマスターしよう #Go - Qiita](https://qiita.com/Syoitu/items/8e7e3215fb7ac9dabc3a)

```go
package main

import (
	"encoding/json"
	"net/http"
)

func main() {
	h1 := func(w http.ResponseWriter, q *http.Request) {
		message := map[string]string{
			"message": "hello world",
		}
		jsonMessage, err := json.Marshal(message)
		if err != nil {
			panic(err.Error())
		}
		w.Write(jsonMessage)
	}

	http.HandleFunc("/", h1)
	http.ListenAndServe("127.0.0.1:3000", mux)
}
```

```go
package main

import (
	"io"
	"log"
	"net/http"
)

func main() {
	h1 := func(w http.ResponseWriter, _ *http.Request) {
		io.WriteString(w, "Hello from a HandleFunc #1!\n")
	}
	h2 := func(w http.ResponseWriter, _ *http.Request) {
		io.WriteString(w, "Hello from a HandleFunc #2!\n")
	}

	http.HandleFunc("/", h1)
	http.HandleFunc("/endpoint", h2)

	log.Fatal(http.ListenAndServe(":8080", nil))
}
```
