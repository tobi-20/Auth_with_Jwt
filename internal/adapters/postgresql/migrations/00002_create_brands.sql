-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS brands(
id BIGSERIAL PRIMARY KEY,
name TEXT UNIQUE NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
