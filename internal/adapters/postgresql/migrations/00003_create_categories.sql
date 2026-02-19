-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS categories(
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL 
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
