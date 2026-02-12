package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	// Local DB Connection
	connStr := "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=familytree sslmode=disable"

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		log.Fatalf("Failed to ping DB: %v", err)
	}

	fmt.Println("--- USERS ---")
	rows, err := db.Query("SELECT id, email, display_name, role FROM users")
	if err != nil {
		log.Fatalf("Error querying users: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var id, email, name, role string
		var emailSql, nameSql sql.NullString
		if err := rows.Scan(&id, &emailSql, &nameSql, &role); err != nil {
			log.Printf("Error scanning user: %v", err)
			continue
		}
		if emailSql.Valid {
			email = emailSql.String
		}
		if nameSql.Valid {
			name = nameSql.String
		}
		fmt.Printf("ID: %s | Email: %s | Name: %s | Role: %s\n", id, email, name, role)
	}

	fmt.Println("\n--- ADMIN REQUESTS ---")
	reqRows, err := db.Query("SELECT id, user_id, requested_role, status, reason FROM admin_access_requests")
	if err != nil {
		log.Fatalf("Error querying requests: %v", err)
	}
	defer reqRows.Close()

	for reqRows.Next() {
		var id, userId, role, status, reason string
		if err := reqRows.Scan(&id, &userId, &role, &status, &reason); err != nil {
			log.Printf("Error scanning request: %v", err)
			continue
		}
		fmt.Printf("ID: %s | UserID: %s | Role: %s | Status: %s | Reason: %s\n", id, userId, role, status, reason)
	}
}
