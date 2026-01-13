package postgres

import (
	"context"
	"database/sql"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
)

type SuperAdminRequestRepository struct {
	db *sql.DB
}

func NewSuperAdminRequestRepository(db *sql.DB) domain.SuperAdminRequestRepository {
	return &SuperAdminRequestRepository{db: db}
}

func (r *SuperAdminRequestRepository) Create(ctx context.Context, req *domain.SuperAdminRequest) error {
	query := `
		INSERT INTO admin_access_requests (id, user_id, requested_role, status, reason, reviewed_by, updated_at, created_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
	`
	_, err := r.db.ExecContext(ctx, query,
		req.ID, req.UserID, req.RequestedRole, req.Status, req.Reason, req.ReviewedBy, req.UpdatedAt, req.CreatedAt,
	)
	return err
}

func (r *SuperAdminRequestRepository) GetByID(ctx context.Context, id string) (*domain.SuperAdminRequest, error) {
	query := `
		SELECT id, user_id, requested_role, status, reason, reviewed_by, updated_at, created_at
		FROM admin_access_requests
		WHERE id = $1
	`
	row := r.db.QueryRowContext(ctx, query, id)

	var req domain.SuperAdminRequest
	var reviewedBy sql.NullString
	if err := row.Scan(
		&req.ID, &req.UserID, &req.RequestedRole, &req.Status, &req.Reason, &reviewedBy, &req.UpdatedAt, &req.CreatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}
	if reviewedBy.Valid {
		req.ReviewedBy = reviewedBy.String
	}
	return &req, nil
}

func (r *SuperAdminRequestRepository) List(ctx context.Context, status domain.RequestStatus, limit int, offset int) ([]*domain.SuperAdminRequest, error) {
	query := `
		SELECT id, user_id, requested_role, status, reason, reviewed_by, updated_at, created_at
		FROM admin_access_requests
		WHERE ($1 = '' OR status = $1)
		ORDER BY created_at DESC
		LIMIT $2 OFFSET $3
	`
	rows, err := r.db.QueryContext(ctx, query, status, limit, offset)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var requests []*domain.SuperAdminRequest
	for rows.Next() {
		var req domain.SuperAdminRequest
		var reviewedBy sql.NullString
		if err := rows.Scan(
			&req.ID, &req.UserID, &req.RequestedRole, &req.Status, &req.Reason, &reviewedBy, &req.UpdatedAt, &req.CreatedAt,
		); err != nil {
			return nil, err
		}
		if reviewedBy.Valid {
			req.ReviewedBy = reviewedBy.String
		}
		requests = append(requests, &req)
	}
	return requests, nil
}

func (r *SuperAdminRequestRepository) GetLatestByUserID(ctx context.Context, userID string) (*domain.SuperAdminRequest, error) {
	query := `
		SELECT id, user_id, requested_role, status, reason, reviewed_by, updated_at, created_at
		FROM admin_access_requests
		WHERE user_id = $1
		ORDER BY created_at DESC
		LIMIT 1
	`
	row := r.db.QueryRowContext(ctx, query, userID)

	var req domain.SuperAdminRequest
	var reviewedBy sql.NullString
	if err := row.Scan(
		&req.ID, &req.UserID, &req.RequestedRole, &req.Status, &req.Reason, &reviewedBy, &req.UpdatedAt, &req.CreatedAt,
	); err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}
	if reviewedBy.Valid {
		req.ReviewedBy = reviewedBy.String
	}
	return &req, nil
}

func (r *SuperAdminRequestRepository) UpdateStatus(ctx context.Context, id string, status domain.RequestStatus, reviewedBy string) error {
	query := `
		UPDATE admin_access_requests
		SET status = $1, reviewed_by = $2, updated_at = $3
		WHERE id = $4
	`
	_, err := r.db.ExecContext(ctx, query, status, reviewedBy, time.Now(), id)
	return err
}
