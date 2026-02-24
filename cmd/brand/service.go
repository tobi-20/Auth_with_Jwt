package brand

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateBrand(ctx context.Context, name string) (repo.Brand, error)
}

type svc struct {
	repo repo.Querier
}

func NewService(repo repo.Querier) Service {
	return &svc{
		repo: repo,
	}
}

func (s *svc) CreateBrand(ctx context.Context, name string) (repo.Brand, error) {
	return s.repo.CreateBrand(ctx, name)
}
