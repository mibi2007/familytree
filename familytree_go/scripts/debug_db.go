package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	// Try Default Fallback Password
	connStr2 := "host=34.2.28.4 port=5432 user=dev_user password=dev_pass_default dbname=family_tree_dev sslmode=disable"
	fmt.Printf("Connecting with KV (Default): %s\n", connStr2)

	db2, err := sql.Open("postgres", connStr2)
	if err != nil {
		log.Fatal(err)
	}
	if err := db2.Ping(); err != nil {
		log.Fatalf("KV failed: %v", err)
	}
	fmt.Println("Success with Default Password!")
}
