-- +goose Up
-- +goose StatementBegin
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS products(
  id BIGSERIAL PRIMARY KEY,
  uid UUID UNIQUE NOT NULL DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  brand_id BIGSERIAL NOT NULL REFERENCES brands(id),
  category_id BIGSERIAL NOT NULL REFERENCES categories(id),
  description TEXT
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
