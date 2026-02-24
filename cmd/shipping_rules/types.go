package shipping_rules

type CreateShippingRulesParams struct {
	MaxPriceInKobo int64
	MinPriceInKobo int64
	Type           interface{}
	Value          int64
}
