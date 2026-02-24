package orders

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateOrder(ctx context.Context, arg repo.CreateOrderParams) (repo.Order, error)
}

type svc struct {
	repo repo.Queries
}

func (s *svc) CreateOrder(ctx context.Context, arg repo.CreateOrderParams) (repo.Order, error) {
	return s.repo.CreateOrder(ctx, arg)
}
