-- name: CreateUser :one

INSERT INTO users (name,email,password_hash) values ($1, $2, $3) returning *;
INSERT INTO brands (name) values($1) returning *;
INSERT INTO categories (name) values($1) returning *;
INSERT INTO products(name, description) values($1, $2) returning *;