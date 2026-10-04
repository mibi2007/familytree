package postgres

import (
	"context"
	"database/sql"
)

type FamilyAccessService struct {
	db *sql.DB
}

func NewFamilyAccessService(db *sql.DB) *FamilyAccessService {
	return &FamilyAccessService{db: db}
}

func (s *FamilyAccessService) HasFamilyAccess(ctx context.Context, userID, familyID string) (bool, error) {
	const query = `
		SELECT EXISTS (
			SELECT 1
			FROM family_access
			WHERE user_id = $1 AND family_id = $2
		)
	`

	var allowed bool
	if err := s.db.QueryRowContext(ctx, query, userID, familyID).Scan(&allowed); err != nil {
		return false, err
	}
	return allowed, nil
}
