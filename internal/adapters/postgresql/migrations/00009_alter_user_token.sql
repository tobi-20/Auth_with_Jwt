-- +goose Up
-- +goose StatementBegin
ALTER TABLE users
ADD COLUMN token_version INT NOT NULL DEFAULT 0;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
