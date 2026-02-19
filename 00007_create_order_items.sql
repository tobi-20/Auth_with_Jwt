-- +goose Up
-- +goose StatementBegin
CREATE TYPE IF NOT EXISTS disc_type AS ENUM ('flat','percentage');

CREATE TABLE IF NOT EXISTS order_items(
  id BIGSERIAL PRIMARY KEY,
  order_id BIGSERIAL NOT NULL REFERENCES orders(id)
  product_variant_id BIGSERIAL NOT NULL REFERENCES product_variants(id),
  quantity INT NOT NULL,
  price_in_kobo BIGINT NOT NULL --before applying discount
  discount_type disc_type NOT NULL DEFAULT 'flat',
  discount_value BIGINT NOT NULL DEFAULT 0,
  item_total BIGINT NOT NULL -- price after applying discount * quantity

)
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
