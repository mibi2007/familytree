package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		connStr = "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=familytree sslmode=disable"
	}

	email := "binhhm2009@gmail.com"
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	if err := db.Ping(); err != nil {
		log.Fatal(err)
	}

	found := false
	rows, err := db.Query("SELECT id, email, role FROM users")
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()
	for rows.Next() {
		var id, userEmail, role string
		if err := rows.Scan(&id, &userEmail, &role); err != nil {
			log.Printf("Error scanning row: %v", err)
			continue
		}
		fmt.Printf("- ID: %s, Email: %s, Role: %s\n", id, userEmail, role)
		found = found || userEmail == email
	}
	if err := rows.Err(); err != nil {
		log.Fatal(err)
	}

	if found {
		fmt.Printf("\nSummary: User %s was found.\n", email)
	} else {
		fmt.Printf("\nSummary: User %s was NOT found.\n", email)
	}
}
