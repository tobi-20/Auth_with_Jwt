package orders

type CreatedOrder struct {
	ShippingCostKobo    int64
	RawOrderPriceInKobo int64
	DiscountType        interface{}
	DiscountValue       int64
}
