package main

import (
	"context"
	"log"

	"github.com/jackc/pgx/v5"
)

func main() {
	cfg := config{
		addr: ":8080",
	}

	ctx := context.Background()
	conn, err := pgx.Connect(ctx, cfg.db.dsn)
	if err != nil {
		log.Println(err)
	}

	api := &application{
		config: cfg,
		db:     conn,
	}
	if err:= api.run(api.mount()); err!= nil{
		log.Fatal(err.Error())
	}




}

