-- +goose Up
-- +goose StatementBegin

-- Ensure pgcrypto extension exists for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Safe enum creation
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
        CREATE TYPE user_role AS ENUM ('user','staff','admin');
    END IF;
END$$;

-- Safe table creation
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  uid UUID UNIQUE NOT NULL DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  role user_role NOT NULL DEFAULT 'user'
);

-- Safe password hash column addition
ALTER TABLE users
ADD COLUMN IF NOT EXISTS password_hash TEXT NOT NULL;

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS users;
DROP TYPE IF EXISTS user_role;
-- +goose StatementEnd
