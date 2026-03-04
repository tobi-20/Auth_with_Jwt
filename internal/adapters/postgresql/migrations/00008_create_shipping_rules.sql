-- +goose Up
-- +goose StatementBegin

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'cost_method') THEN
        CREATE TYPE cost_method AS ENUM('flat','percentage');
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS shipping_rules(
  id BIGSERIAL PRIMARY KEY,
  min_price_in_kobo BIGINT NOT NULL DEFAULT 0,
  max_price_in_kobo BIGINT NOT NULL DEFAULT 0,
  type cost_method NOT NULL DEFAULT 'flat',
  value BIGINT NOT NULL DEFAULT 0
);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS shipping_rules;
DROP TYPE IF EXISTS cost_method;
-- +goose StatementEnd