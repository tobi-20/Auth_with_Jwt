-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS product_variants (
  id BIGSERIAL PRIMARY KEY,
  product_id BIGINT NOT NULL REFERENCES products(id),
  weight INT NOT NULL,
  unit TEXT NOT NULL,
  price_in_kobo BIGINT NOT NULL,
  stock INT NOT NULL DEFAULT 0
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS product_variants;
-- +goose StatementEnd