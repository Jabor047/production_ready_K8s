package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "こんにちは, 世界!")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Running demo app. press ctrl+c to stop...")
	log.Fatal(http.ListenAndServe(":8866", nil))
}