-- name: CreateUser :one

INSERT INTO users (name,email,password_hash) values ('josephus kalizzy', 'jboss@example.com', 'chingege') returning *;