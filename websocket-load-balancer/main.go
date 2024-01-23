// main.go
package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/websocket"
	"github.com/redis/go-redis/v9"
)

type Handler struct {
	mux         http.ServeMux
	redisClient redis.Client
}

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

func (h *Handler) handleConnection(w http.ResponseWriter, r *http.Request) {
	conn, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer conn.Close()

	for {
		messageType, _, err := conn.ReadMessage()
		if err != nil {
			fmt.Println(err)
			return
		}

		counter, err := h.redisClient.Incr(context.Background(), "counter").Result()
		if err != nil {
			log.Println(err)
		}

		fmt.Println("From Redis: ", counter)

		resp := strconv.Itoa(int(counter))
		if err := conn.WriteMessage(messageType, []byte(resp)); err != nil {
			fmt.Println(err)
			return
		}
	}
}

func (h *Handler) healthCheck(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func main() {

	redisClient := redis.NewClient(&redis.Options{
		Addr:     "redis:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	handler := Handler{
		mux:         *http.DefaultServeMux,
		redisClient: *redisClient,
	}

	handler.mux.HandleFunc("/", handler.handleConnection)
	handler.mux.HandleFunc("/health-check", handler.healthCheck)
	port := "9100"
	fmt.Println("Server is running on :", port)
	http.ListenAndServe(fmt.Sprintf(":%s", port), &handler.mux)
}
