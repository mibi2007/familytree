package main

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

func main() {
	// Trying both passwords
	connStrings := []string{
		"host=127.0.0.1 port=5432 user=postgres password=postgres dbname=familytree sslmode=disable",
		"host=34.2.28.4 port=5432 user=dev_user password=Zaq1@wsx dbname=family_tree_dev sslmode=disable",
		"host=34.2.28.4 port=5432 user=dev_user password=dev_pass_default dbname=family_tree_dev sslmode=disable",
	}

	email := "binhhm2009@gmail.com"
	found := false

	for _, connStr := range connStrings {
		db, err := sql.Open("postgres", connStr)
		if err != nil {
			fmt.Printf("Failed to open connection for: %s\n", connStr)
			continue
		}

		err = db.Ping()
		if err != nil {
			fmt.Printf("Failed to ping DB: %s\n", connStr)
			db.Close()
			continue
		}

		fmt.Printf("\n--- Checking Database: %s ---\n", connStr)

		foundInThisDb := false
		rows, err := db.Query("SELECT id, email, role FROM users")
		if err != nil {
			fmt.Printf("Error querying users: %v\n", err)
			db.Close()
			continue
		}

		for rows.Next() {
			var id, userEmail, role string
			if err := rows.Scan(&id, &userEmail, &role); err != nil {
				fmt.Printf("Error scanning row: %v\n", err)
				continue
			}
			fmt.Printf("- ID: %s, Email: %s, Role: %s\n", id, userEmail, role)
			if userEmail == email {
				foundInThisDb = true
				found = true
			}
		}
		rows.Close()

		if foundInThisDb {
			fmt.Printf("✅ User %s FOUND in this database.\n", email)
		} else {
			fmt.Printf("❌ User %s NOT FOUND in this database.\n", email)
		}

		db.Close()
	}

	if found {
		fmt.Printf("\nSummary: User %s was found in at least one database.\n", email)
	} else {
		fmt.Printf("\nSummary: User %s was NOT found in any database.\n", email)
	}
}
