-- +goose Up
-- +goose StatementBegin

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'disc_type') THEN
        CREATE TYPE disc_type AS ENUM ('flat','percentage');
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS order_items(
  id BIGSERIAL PRIMARY KEY,
  order_id BIGINT NOT NULL REFERENCES orders(id),
  product_variant_id BIGINT NOT NULL REFERENCES product_variants(id),
  quantity INT NOT NULL,
  price_in_kobo BIGINT NOT NULL,
  discount_type disc_type NOT NULL DEFAULT 'flat',
  discount_value BIGINT NOT NULL DEFAULT 0,
  item_total BIGINT NOT NULL
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS order_items;
-- +goose StatementEnd