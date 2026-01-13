package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	if len(os.Args) < 2 {
		log.Fatal("Usage: go run promote_admin.go <user_id>")
	}

	userID := os.Args[1]
	connStr := "host=34.2.28.4 port=5432 user=dev_user password=Zaq1@wsx dbname=family_tree_dev sslmode=disable"

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatalf("Failed to connect: %v", err)
	}
	defer db.Close()

	// First, ensure the user exists (insert if not)
	_, err = db.Exec(`
		INSERT INTO users (id, email, display_name, role, created_at) 
		VALUES ($1, $1, 'Admin User', 'SUPER_ADMIN', NOW())
		ON CONFLICT (id) DO UPDATE SET role = 'SUPER_ADMIN'
	`, userID)
	if err != nil {
		log.Fatalf("Failed to promote user: %v", err)
	}

	fmt.Printf("✅ Successfully promoted user %s to SUPER_ADMIN\n", userID)
	fmt.Println("\nℹ️  The user record has been created/updated in the database.")
	fmt.Println("   They can now sign in to the Admin App and will have SUPER_ADMIN privileges.")
}
