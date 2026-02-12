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

func (r *UserRepository) GetUserByEmail(ctx context.Context, email string) (*domain.User, error) {
	query := `SELECT id, email, display_name, photo_url, email_verified, role, deletion_requested_at, created_at, updated_at FROM users WHERE email = $1`
	row := r.db.QueryRowContext(ctx, query, email)

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

func (r *UserRepository) UpdateUserID(ctx context.Context, oldID, newID string) error {
	// Use a transaction to safely migrate the user ID
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	// 1. Create a temporary table with the old user's data
	// ON COMMIT DROP ensures the temp table is cleaned up at end of transaction
	if _, err := tx.ExecContext(ctx, `CREATE TEMP TABLE _user_migration ON COMMIT DROP AS SELECT * FROM users WHERE id = $1`, oldID); err != nil {
		return err
	}

	// 2. Nullify unique fields (email, phone) in the OLD record to free up constraints
	// We keep the old record momentarily to satisfy FKs until we repoint them
	if _, err := tx.ExecContext(ctx, `UPDATE users SET email = NULL, phone = NULL WHERE id = $1`, oldID); err != nil {
		return err
	}

	// 3. Update the ID in the temp table to the new ID
	if _, err := tx.ExecContext(ctx, `UPDATE _user_migration SET id = $1`, newID); err != nil {
		return err
	}

	// 4. Insert the new record from the temp table
	// This works because we nullified the unique fields in the old record
	if _, err := tx.ExecContext(ctx, `INSERT INTO users SELECT * FROM _user_migration`); err != nil {
		return err
	}

	// 5. Update all foreign key references to point to the new ID
	queries := []string{
		`UPDATE admin_access_requests SET user_id = $1 WHERE user_id = $2`,
		`UPDATE admin_access_requests SET reviewed_by = $1 WHERE reviewed_by = $2`,
		`UPDATE secure_tokens SET created_by = $1 WHERE created_by = $2`,
		`UPDATE families SET owner_id = $1 WHERE owner_id = $2`,
		`UPDATE family_members SET user_id = $1 WHERE user_id = $2`,
		`UPDATE admin_activity_logs SET admin_id = $1 WHERE admin_id = $2`,
	}

	for _, query := range queries {
		if _, err := tx.ExecContext(ctx, query, newID, oldID); err != nil {
			return err
		}
	}

	// 6. Delete the old user record
	if _, err := tx.ExecContext(ctx, `DELETE FROM users WHERE id = $1`, oldID); err != nil {
		return err
	}

	return tx.Commit()
}

func (r *UserRepository) ListUsersByRole(ctx context.Context, role domain.SystemRole, limit int, offset int) ([]*domain.User, error) {
	query := `
		SELECT id, email, display_name, photo_url, email_verified, role, deletion_requested_at, created_at, updated_at
		FROM users
		WHERE role = $1
		ORDER BY created_at ASC
		LIMIT $2 OFFSET $3
	`
	rows, err := r.db.QueryContext(ctx, query, role, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var users []*domain.User
	for rows.Next() {
		var user domain.User
		var deletionRequestedAt sql.NullTime
		if err := rows.Scan(
			&user.ID, &user.Email, &user.DisplayName, &user.PhotoURL, &user.EmailVerified, &user.Role, &deletionRequestedAt, &user.CreatedAt, &user.UpdatedAt,
		); err != nil {
			return nil, err
		}
		if deletionRequestedAt.Valid {
			user.DeletionRequestedAt = &deletionRequestedAt.Time
		}
		users = append(users, &user)
	}
	return users, nil
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
