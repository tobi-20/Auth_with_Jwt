-- +goose Up
-- +goose StatementBegin
CREATE TYPE IF NOT EXISTS order_status AS ENUM ('Pending','Processing','Complete','Rejected');
CREATE TYPE IF NOT EXISTS disc_type AS ENUM ('flat','percentage');

CREATE TABLE IF NOT EXISTS orders(
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGSERIAL NOT NULL REFERENCES users(id),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  shipping_cost_kobo BIGINT NOT NULL DEFAULT 0,
  raw_order_price_in_kobo BIGINT NOT NULL DEFAULT 0,
  discount_type disc_type NOT NULL DEFAULT 'flat',
  discount_value BIGINT NOT NULL DEFAULT 0,
  order_total BIGINT NOT NULL DEFAULT 0  ---order_price_in_kobo-discount_value
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
