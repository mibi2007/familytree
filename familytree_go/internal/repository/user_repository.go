package repository

import (
	"context"
	"database/sql"
	"time"
)

type User struct {
	ID          string // Firebase UID
	Email       string
	DisplayName string
	PhotoURL    string
	CreatedAt   time.Time
	UpdatedAt   time.Time
}

type UserRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) *UserRepository {
	return &UserRepository{db: db}
}

func (r *UserRepository) UpsertUser(ctx context.Context, user *User) error {
	query := `
		INSERT INTO users (id, email, display_name, photo_url, created_at, updated_at)
		VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ON CONFLICT (id) DO UPDATE SET
			email = EXCLUDED.email,
			display_name = EXCLUDED.display_name,
			photo_url = EXCLUDED.photo_url,
			updated_at = CURRENT_TIMESTAMP
	`
	_, err := r.db.ExecContext(ctx, query,
		user.ID, user.Email, user.DisplayName, user.PhotoURL,
	)
	return err
}

func (r *UserRepository) GetUserByID(ctx context.Context, id string) (*User, error) {
	query := `SELECT id, email, display_name, photo_url, created_at, updated_at FROM users WHERE id = $1`
	row := r.db.QueryRowContext(ctx, query, id)

	var user User
	err := row.Scan(&user.ID, &user.Email, &user.DisplayName, &user.PhotoURL, &user.CreatedAt, &user.UpdatedAt)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	return &user, nil
}
