package users

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateUser(ctx context.Context) (repo.User, error)
}

type svc struct {
	repo repo.Querier
}

func NewService(repo repo.Querier) Service {
	return &svc{
		repo: repo,
	}
}
func (s *svc) CreateUser(ctx context.Context) (repo.User, error) {
	return s.repo.CreateUser(ctx)

}
