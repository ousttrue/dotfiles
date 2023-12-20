package main

import (
	"log"
	"net/http"
	"os"

	"golang.org/x/net/websocket"
)

var json []byte = nil

func msgHandler(ws *websocket.Conn) {
	// defer ws.Close()

	log.Printf("new connection")

	err := websocket.Message.Send(ws, json)
	if err != nil {
		log.Fatalln(err)
	}

	// for {
	// 	// メッセージを受信する
	// 	msg := ""
	// 	err = websocket.Message.Receive(ws, &msg)
	// 	if err != nil {
	// 		log.Fatalln(err)
	// 	}
	//
	// 	// メッセージを返信する
	// 	err := websocket.Message.Send(ws, fmt.Sprintf(`%q というメッセージを受け取りました。`, msg))
	// 	if err != nil {
	// 		log.Fatalln(err)
	// 	}
	// }
}

func main() {
	port := "8080"

	bytes, err := os.ReadFile("sites.json")
	if err != nil {
		panic("fail to load sites.json")
	}
	json = bytes

	http.Handle("/", http.FileServer(http.Dir("../public/"))) // ①
	http.Handle("/ws", websocket.Handler(msgHandler))

	log.Printf("Server listening on http://localhost:%s/", port)
	log.Print(http.ListenAndServe(":"+port, nil))
}
