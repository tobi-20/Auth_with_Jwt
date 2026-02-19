-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS product_variants(
  id BIGSERIAL PRIMARY KEY,
  product_id BIGSERIAL NOT NULL REFERENCES product(id),
  weight INT NOT NULL,
  unit TEXT NOT NULL,
  price_in_kobo BIGINT NOT NULL,
  stock INT NOT NULL DEFAULT 0
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
