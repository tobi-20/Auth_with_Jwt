package products

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateProduct(ctx context.Context, args repo.CreateProductParams) (repo.Product, error)
}

type svc struct {
	repo repo.Queries
}

func (s *svc) CreateProduct(ctx context.Context, args repo.CreateProductParams) (repo.Product, error) {
	return s.repo.CreateProduct(ctx, args)
}
