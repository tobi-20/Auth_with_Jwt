package order_items

type CreatedOrderItemResponse struct {
	Quantity      int32
	PriceInKobo   int64
	DiscountType  interface{}
	DiscountValue int64
	ItemTotal     int64
}
