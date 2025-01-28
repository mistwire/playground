// main.go
package main

import (
    "log"
    "net/http"
    "github.com/gorilla/mux"
)

func main() {
    r := mux.NewRouter()
    
    // Serve static files
    r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))
    
    // API routes
    r.HandleFunc("/api/game", handlers.NewGame).Methods("POST")
    r.HandleFunc("/api/guess", handlers.MakeGuess).Methods("POST")
    
    log.Fatal(http.ListenAndServe(":8080", r))
}

