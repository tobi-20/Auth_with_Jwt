-- +goose Up
-- +goose StatementBegin
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
    CREATE TYPE order_status AS ENUM ('Pending','Processing','Complete','Rejected');
  END IF;
END$$;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'disc_type') THEN
    CREATE TYPE disc_type AS ENUM ('flat','percentage');
  END IF;
END$$;

CREATE TABLE IF NOT EXISTS orders(
  id BIGSERIAL PRIMARY KEY,
  customer_id BIGINT NOT NULL REFERENCES users(id),
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
