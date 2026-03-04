package auth

import (
	"Lanixpress/cmd/helpers"
	repo "Lanixpress/internal/adapters/postgresql/sqlc"
	"errors"
	"time"

	"Lanixpress/internal/json"
	"log"

	"net/http"

	"golang.org/x/crypto/bcrypt"
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
	var user CreateUserRequest

	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusMethodNotAllowed)
		return
	}
	if err := json.Read(r, &user); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	hashedPassword, err := helpers.HashPassword(user.Password)

	if err != nil {
		http.Error(w, "password not hashed successfully", http.StatusInternalServerError)
		return
	}

	params := repo.CreateUserParams{
		Name:         user.Name,
		Email:        user.Email,
		PasswordHash: hashedPassword,
	}

	createdUser, err := h.service.CreateUser(r.Context(), params)
	if err != nil {
		log.Println(err)
	}

	resp := &CreateUserResp{
		Name:  createdUser.Name,
		Email: createdUser.Email,
	}

	json.Write(w, http.StatusCreated, resp)
	log.Println("REQ:", user.Name, user.Email, user.Password)
}

func (h *handler) Login(w http.ResponseWriter, r *http.Request) {
	var req LoginReq
	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusBadRequest)
		return
	}

	if err := json.Read(r, &req); err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	accessToken, rawRefreshToken, err := h.service.Login(r.Context(), &req)
	if err != nil {
		log.Println(err.Error())
		http.Error(w, "invalid credentials", http.StatusUnauthorized)
		return
		// os.Exit(1) never do this it kills the server

	}
	http.SetCookie(w, &http.Cookie{
		Name:     "refresh_token",
		Value:    rawRefreshToken,
		Path:     "/",
		HttpOnly: true,
		Secure:   false,
		SameSite: http.SameSiteNoneMode,
		Expires:  time.Now().Add(7 * 24 * time.Hour),
	})

	json.Write(w, http.StatusAccepted, map[string]string{
		"access_token":  accessToken,
		"refresh_token": rawRefreshToken,
	})
}
func (h *handler) GetUserByEmail(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "method not allowed", http.StatusBadRequest)
		return
	}
}

func (h *handler) RefreshToken(w http.ResponseWriter, r *http.Request) (string, error) {
	cookie, err := r.Cookie("refresh_token")

	if err != nil {
		return "", errors.New("missing refresh token")
	}
	rawToken := cookie.Value
	tokenID, secret, ok := helpers.SplitToken(rawToken)
	if !ok {
		return "", errors.New("invalid token format")
	}

	stored, err := h.service.GetRefreshTokenByID(r.Context(), tokenID)
	if err != nil {
		return "", errors.New("Unable to fetch token")
	}
	if time.Now().After(stored.ExpiresAt.Time) {
		return "", errors.New("token expired")
	}

	err = bcrypt.CompareHashAndPassword([]byte(stored.HashedToken), []byte(secret))
	if err != nil {
		return "", errors.New("Invalid token")
	}
	err = h.service.DeleteRefreshTokenByUserID(r.Context())

	return tokenID, nil
}
