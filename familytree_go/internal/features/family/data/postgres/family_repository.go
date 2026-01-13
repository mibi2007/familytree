package postgres

import (
	"context"
	"database/sql"

	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
)

type FamilyRepository struct {
	db *sql.DB
}

func NewFamilyRepository(db *sql.DB) domain.FamilyRepository {
	return &FamilyRepository{db: db}
}

func (r *FamilyRepository) Create(ctx context.Context, f *domain.Family) error {
	tx, err := r.db.BeginTx(ctx, nil)
	if err != nil {
		return err
	}
	defer tx.Rollback()

	query := `
		INSERT INTO families (name, owner_id, ai_behavior_instructions, created_at, updated_at)
		VALUES ($1, $2, $3, NOW(), NOW())
		RETURNING id, created_at, updated_at
	`
	err = tx.QueryRowContext(ctx, query, f.Name, f.OwnerID, f.AIBehaviorInstructions).
		Scan(&f.ID, &f.CreatedAt, &f.UpdatedAt)
	if err != nil {
		return err
	}

	// Also add owner access
	accessQuery := `INSERT INTO family_access (family_id, user_id, role) VALUES ($1, $2, 'OWNER')`
	if _, err := tx.ExecContext(ctx, accessQuery, f.ID, f.OwnerID); err != nil {
		return err
	}

	return tx.Commit()
}

func (r *FamilyRepository) GetByID(ctx context.Context, id string) (*domain.Family, error) {
	query := `
		SELECT id, name, owner_id, ai_behavior_instructions, created_at, updated_at
		FROM families
		WHERE id = $1
	`
	row := r.db.QueryRowContext(ctx, query, id)

	var f domain.Family
	if err := row.Scan(&f.ID, &f.Name, &f.OwnerID, &f.AIBehaviorInstructions, &f.CreatedAt, &f.UpdatedAt); err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}
	return &f, nil
}

func (r *FamilyRepository) Update(ctx context.Context, f *domain.Family) error {
	query := `
		UPDATE families
		SET name = $1, owner_id = $2, ai_behavior_instructions = $3, updated_at = NOW()
		WHERE id = $4
	`
	_, err := r.db.ExecContext(ctx, query, f.Name, f.OwnerID, f.AIBehaviorInstructions, f.ID)
	return err
}

func (r *FamilyRepository) Delete(ctx context.Context, id string) error {
	query := `DELETE FROM families WHERE id = $1`
	_, err := r.db.ExecContext(ctx, query, id)
	return err
}

func (r *FamilyRepository) ListByOwner(ctx context.Context, ownerID string) ([]*domain.Family, error) {
	query := `
		SELECT id, name, owner_id, ai_behavior_instructions, created_at, updated_at
		FROM families
		WHERE owner_id = $1
		ORDER BY created_at DESC
	`
	rows, err := r.db.QueryContext(ctx, query, ownerID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var families []*domain.Family
	for rows.Next() {
		var f domain.Family
		if err := rows.Scan(&f.ID, &f.Name, &f.OwnerID, &f.AIBehaviorInstructions, &f.CreatedAt, &f.UpdatedAt); err != nil {
			return nil, err
		}
		families = append(families, &f)
	}
	return families, nil
}

func (r *FamilyRepository) AddAccess(ctx context.Context, familyID string, userID string, role string) error {
	query := `
		INSERT INTO family_access (family_id, user_id, role)
		VALUES ($1, $2, $3)
		ON CONFLICT (family_id, user_id) DO UPDATE SET role = EXCLUDED.role
	`
	_, err := r.db.ExecContext(ctx, query, familyID, userID, role)
	return err
}

func (r *FamilyRepository) ListByMember(ctx context.Context, userID string) ([]*domain.Family, error) {
	query := `
		SELECT f.id, f.name, f.owner_id, f.ai_behavior_instructions, f.created_at, f.updated_at
		FROM families f
		JOIN family_access fa ON f.id = fa.family_id
		WHERE fa.user_id = $1
		ORDER BY f.created_at DESC
	`
	rows, err := r.db.QueryContext(ctx, query, userID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var families []*domain.Family
	for rows.Next() {
		var f domain.Family
		if err := rows.Scan(&f.ID, &f.Name, &f.OwnerID, &f.AIBehaviorInstructions, &f.CreatedAt, &f.UpdatedAt); err != nil {
			return nil, err
		}
		families = append(families, &f)
	}
	return families, nil
}
