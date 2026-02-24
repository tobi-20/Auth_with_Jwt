package shipping_rules

import (
	"context"

	repo "github.com/tobi-20/Lanixpress/internal/adapters/postgresql/sqlc"
)

type Service interface {
	CreateShippingRules(ctx context.Context, arg repo.CreateShippingRulesParams) (repo.ShippingRule, error)
}

type svc struct {
	repo repo.Queries
}

func (s *svc) CreateShippingRules(ctx context.Context, arg repo.CreateShippingRulesParams) (repo.ShippingRule, error) {
	return s.repo.CreateShippingRules(ctx, arg)
}
