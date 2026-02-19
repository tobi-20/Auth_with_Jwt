package users

type userResponse struct {
	
	Name  string `json:"name"`
	Email string `json:"email"`
	Role  any    `json:"role"`
}
