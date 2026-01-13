package postgres

import (
	"context"
	"database/sql"

	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
)

type MemberRepository struct {
	db *sql.DB
}

func NewMemberRepository(db *sql.DB) domain.MemberRepository {
	return &MemberRepository{db: db}
}

func (r *MemberRepository) Create(ctx context.Context, m *domain.Member) error {
	query := `
		INSERT INTO family_members (id, family_id, display_name, birth_date, gender, level, parent_id, spouse_id, user_id, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, NOW(), NOW())
		RETURNING created_at, updated_at
	`
	var parentID, spouseID, userID sql.NullString
	if m.ParentID != "" {
		parentID = sql.NullString{String: m.ParentID, Valid: true}
	}
	if m.SpouseID != "" {
		spouseID = sql.NullString{String: m.SpouseID, Valid: true}
	}
	if m.UserID != "" {
		userID = sql.NullString{String: m.UserID, Valid: true}
	}

	return r.db.QueryRowContext(ctx, query,
		m.ID, m.FamilyID, m.DisplayName, m.BirthDate, m.Gender, m.Level, parentID, spouseID, userID,
	).Scan(&m.CreatedAt, &m.UpdatedAt)
}

func (r *MemberRepository) GetByID(ctx context.Context, id string) (*domain.Member, error) {
	query := `
		SELECT id, family_id, display_name, birth_date, gender, level, parent_id, spouse_id, user_id, created_at, updated_at
		FROM family_members
		WHERE id = $1
	`
	row := r.db.QueryRowContext(ctx, query, id)

	var m domain.Member
	var parentID, spouseID, userID sql.NullString
	var birthDate sql.NullString

	err := row.Scan(
		&m.ID, &m.FamilyID, &m.DisplayName, &birthDate, &m.Gender, &m.Level, &parentID, &spouseID, &userID, &m.CreatedAt, &m.UpdatedAt,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil
		}
		return nil, err
	}

	if parentID.Valid {
		m.ParentID = parentID.String
	}
	if spouseID.Valid {
		m.SpouseID = spouseID.String
	}
	if userID.Valid {
		m.UserID = userID.String
	}
	if birthDate.Valid {
		m.BirthDate = birthDate.String
	}

	return &m, nil
}

func (r *MemberRepository) Update(ctx context.Context, m *domain.Member) error {
	query := `
		UPDATE family_members
		SET family_id = $1, display_name = $2, birth_date = $3, gender = $4, level = $5, parent_id = $6, spouse_id = $7, user_id = $8, updated_at = NOW()
		WHERE id = $9
	`
	var parentID, spouseID, userID sql.NullString
	if m.ParentID != "" {
		parentID = sql.NullString{String: m.ParentID, Valid: true}
	}
	if m.SpouseID != "" {
		spouseID = sql.NullString{String: m.SpouseID, Valid: true}
	}
	if m.UserID != "" {
		userID = sql.NullString{String: m.UserID, Valid: true}
	}

	_, err := r.db.ExecContext(ctx, query,
		m.FamilyID, m.DisplayName, m.BirthDate, m.Gender, m.Level, parentID, spouseID, userID, m.ID,
	)
	return err
}

func (r *MemberRepository) Delete(ctx context.Context, id string) error {
	query := `DELETE FROM family_members WHERE id = $1`
	_, err := r.db.ExecContext(ctx, query, id)
	return err
}

func (r *MemberRepository) ListByFamily(ctx context.Context, familyID string) ([]*domain.Member, error) {
	query := `
		SELECT id, family_id, display_name, birth_date, gender, level, parent_id, spouse_id, user_id, created_at, updated_at
		FROM family_members
		WHERE family_id = $1
		ORDER BY level ASC, created_at ASC
	`
	rows, err := r.db.QueryContext(ctx, query, familyID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var members []*domain.Member
	for rows.Next() {
		var m domain.Member
		var parentID, spouseID, userID sql.NullString
		var birthDate sql.NullString

		err := rows.Scan(
			&m.ID, &m.FamilyID, &m.DisplayName, &birthDate, &m.Gender, &m.Level, &parentID, &spouseID, &userID, &m.CreatedAt, &m.UpdatedAt,
		)
		if err != nil {
			return nil, err
		}

		if parentID.Valid {
			m.ParentID = parentID.String
		}
		if spouseID.Valid {
			m.SpouseID = spouseID.String
		}
		if userID.Valid {
			m.UserID = userID.String
		}
		if birthDate.Valid {
			m.BirthDate = birthDate.String
		}

		members = append(members, &m)
	}
	return members, nil
}
