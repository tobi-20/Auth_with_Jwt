package users

import (
	"log"
	"net/http"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
	"github.com/tobi-20/Lanixpress/internal/json"
)

type handler struct {
	service Service
}

func NewHandler(service Service) *handler {
	return &handler{
		service: service,
	}
}

func (h *handler) CreateUser(w http.ResponseWriter, r *http.Request) {
	var tempUser repo.User

	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}
	if err := json.Read(r, tempUser); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	createdUser, err := h.service.CreateUser(r.Context())

	if err != nil {
		log.Println(err)
	}

	json.Write(w, http.StatusCreated, createdUser)
}
