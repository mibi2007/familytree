package domain

import (
	"context"
	"time"
)

type Family struct {
	ID                     string    `json:"id"`
	Name                   string    `json:"name"`
	OwnerID                string    `json:"owner_id"`
	AIBehaviorInstructions string    `json:"ai_behavior_instructions"`
	CreatedAt              time.Time `json:"created_at"`
	UpdatedAt              time.Time `json:"updated_at"`
}

type Member struct {
	ID          string    `json:"id"`
	FamilyID    string    `json:"family_id"`
	DisplayName string    `json:"display_name"`
	BirthDate   string    `json:"birth_date"`
	Gender      string    `json:"gender"`
	Level       int       `json:"level"`
	ParentID    string    `json:"parent_id"`
	SpouseID    string    `json:"spouse_id"`
	UserID      string    `json:"user_id"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type FamilyRepository interface {
	Create(ctx context.Context, family *Family) error
	GetByID(ctx context.Context, id string) (*Family, error)
	Update(ctx context.Context, family *Family) error
	Delete(ctx context.Context, id string) error
	ListByOwner(ctx context.Context, ownerID string) ([]*Family, error)
	AddAccess(ctx context.Context, familyID string, userID string, role string) error
	ListByMember(ctx context.Context, userID string) ([]*Family, error)
}

type MemberRepository interface {
	Create(ctx context.Context, member *Member) error
	GetByID(ctx context.Context, id string) (*Member, error)
	Update(ctx context.Context, member *Member) error
	Delete(ctx context.Context, id string) error
	ListByFamily(ctx context.Context, familyID string) ([]*Member, error)
}
