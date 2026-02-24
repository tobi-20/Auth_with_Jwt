package product_variants

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateProductVariant(ctx context.Context, arg repo.CreateProductVariantParams) (repo.ProductVariant, error)
}

type svc struct {
	repo repo.Queries
}

func (s *svc) CreateProductVariant(ctx context.Context, arg repo.CreateProductVariantParams) (repo.ProductVariant, error) {
	return s.repo.CreateProductVariant(ctx, arg)
}
