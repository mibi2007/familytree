package repository

import (
	"context"
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type TokenPurpose string

const (
	PurposeAdminOnboarding TokenPurpose = "ADMIN_ONBOARDING"
	PurposeFamilyInvite    TokenPurpose = "FAMILY_INVITE"
	PurposeSupportGrant    TokenPurpose = "SUPPORT_GRANT"
)

type SecureToken struct {
	Token        string
	Purpose      TokenPurpose
	AssociatedID *uuid.UUID
	CreatedBy    string
	ExpiresAt    *time.Time
	IsUsed       bool
	CreatedAt    time.Time
}

type TokenRepository struct {
	db *sql.DB
}

func NewTokenRepository(db *sql.DB) *TokenRepository {
	return &TokenRepository{db: db}
}

func (r *TokenRepository) Create(ctx context.Context, token *SecureToken) error {
	query := `
		INSERT INTO secure_tokens (token, purpose, associated_id, created_by, expires_at, is_used, created_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`
	_, err := r.db.ExecContext(ctx, query,
		token.Token, token.Purpose, token.AssociatedID, token.CreatedBy,
		token.ExpiresAt, token.IsUsed, token.CreatedAt,
	)
	return err
}

func (r *TokenRepository) Get(ctx context.Context, tokenStr string) (*SecureToken, error) {
	query := `
		SELECT token, purpose, associated_id, created_by, expires_at, is_used, created_at
		FROM secure_tokens WHERE token = $1
	`
	row := r.db.QueryRowContext(ctx, query, tokenStr)
	var t SecureToken
	err := row.Scan(&t.Token, &t.Purpose, &t.AssociatedID, &t.CreatedBy, &t.ExpiresAt, &t.IsUsed, &t.CreatedAt)
	if err != nil {
		return nil, err
	}
	return &t, nil
}

func (r *TokenRepository) MarkAsUsed(ctx context.Context, tokenStr string) error {
	query := `UPDATE secure_tokens SET is_used = TRUE WHERE token = $1`
	_, err := r.db.ExecContext(ctx, query, tokenStr)
	return err
}

func (r *TokenRepository) DeleteExpired(ctx context.Context) (int64, error) {
	query := `DELETE FROM secure_tokens WHERE expires_at < NOW() AND expires_at IS NOT NULL`
	result, err := r.db.ExecContext(ctx, query)
	if err != nil {
		return 0, err
	}
	return result.RowsAffected()
}
