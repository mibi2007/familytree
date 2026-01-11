package postgres

import (
	"context"
	"database/sql"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
)

type UserRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) domain.UserRepository {
	return &UserRepository{db: db}
}

func (r *UserRepository) UpsertUser(ctx context.Context, user *domain.User) error {
	query := `
		INSERT INTO users (id, email, display_name, photo_url, email_verified, role, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
		ON CONFLICT (id) DO UPDATE SET
			email = EXCLUDED.email,
			display_name = EXCLUDED.display_name,
			photo_url = EXCLUDED.photo_url,
			email_verified = EXCLUDED.email_verified,
			updated_at = CURRENT_TIMESTAMP
		RETURNING created_at, role
	`

	err := r.db.QueryRowContext(ctx, query,
		user.ID, user.Email, user.DisplayName, user.PhotoURL, user.EmailVerified, user.Role,
	).Scan(&user.CreatedAt, &user.Role)
	return err
}

func (r *UserRepository) GetUserByID(ctx context.Context, id string) (*domain.User, error) {
	query := `SELECT id, email, display_name, photo_url, email_verified, role, deletion_requested_at, created_at, updated_at FROM users WHERE id = $1`
	row := r.db.QueryRowContext(ctx, query, id)

	var user domain.User
	var deletionRequestedAt sql.NullTime
	err := row.Scan(
		&user.ID, &user.Email, &user.DisplayName, &user.PhotoURL, &user.EmailVerified, &user.Role, &deletionRequestedAt, &user.CreatedAt, &user.UpdatedAt,
	)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}
	if deletionRequestedAt.Valid {
		user.DeletionRequestedAt = &deletionRequestedAt.Time
	}
	return &user, nil
}

func (r *UserRepository) MarkDeletionRequested(ctx context.Context, id string, requestedAt time.Time) error {
	query := `UPDATE users SET deletion_requested_at = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2`
	_, err := r.db.ExecContext(ctx, query, requestedAt, id)
	return err
}

func (r *UserRepository) SetUserRole(ctx context.Context, id string, role domain.SystemRole) error {
	query := `UPDATE users SET role = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2`
	_, err := r.db.ExecContext(ctx, query, role, id)
	return err
}
