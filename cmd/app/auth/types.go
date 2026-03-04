package auth

type CreateUserRequest struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password"`
}
type CreateUserResp struct {
	Name  string
	Email string
}

type User struct {
	ID           int64
	Name         string
	Email        string
	PasswordHash string
	TokenVersion int32
}

type LoginReq struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

type LogoutReq struct {
	ID int64 `json:"id"`
}
