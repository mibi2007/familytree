package app

import (
	"context"
	"fmt"
	"time"

	authdomain "github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
)

type FamilyService struct {
	familyRepo domain.FamilyRepository
	memberRepo domain.MemberRepository
	tokenRepo  authdomain.TokenRepository
}

func NewFamilyService(familyRepo domain.FamilyRepository, memberRepo domain.MemberRepository, tokenRepo authdomain.TokenRepository) *FamilyService {
	return &FamilyService{
		familyRepo: familyRepo,
		memberRepo: memberRepo,
		tokenRepo:  tokenRepo,
	}
}

func (s *FamilyService) CreateFamily(ctx context.Context, name string) (*domain.Family, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, fmt.Errorf("unauthenticated")
	}

	family := &domain.Family{
		Name:    name,
		OwnerID: user.UID,
	}

	if err := s.familyRepo.Create(ctx, family); err != nil {
		return nil, err
	}

	return family, nil
}

func (s *FamilyService) GetFamily(ctx context.Context, id string) (*domain.Family, error) {
	return s.familyRepo.GetByID(ctx, id)
}

func (s *FamilyService) ListMyFamilies(ctx context.Context) ([]*domain.Family, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, fmt.Errorf("unauthenticated")
	}
	return s.familyRepo.ListByMember(ctx, user.UID)
}

func (s *FamilyService) AddMember(ctx context.Context, familyID, displayName, parentID, spouseID string) (*domain.Member, error) {
	// Check if family exists and user has access (for now owner check)
	family, err := s.familyRepo.GetByID(ctx, familyID)
	if err != nil {
		return nil, err
	}
	if family == nil {
		return nil, fmt.Errorf("family not found")
	}

	user := middleware.GetUser(ctx)
	if user == nil || family.OwnerID != user.UID {
		return nil, fmt.Errorf("unauthorized")
	}

	// Calculate level based on parent
	level := 0
	if parentID != "" {
		parent, err := s.memberRepo.GetByID(ctx, parentID)
		if err != nil {
			return nil, err
		}
		if parent != nil {
			level = parent.Level + 1
		}
	}

	// Generate ID: member_{timestamp}_{rand}
	id := fmt.Sprintf("member_%d", time.Now().UnixNano())

	member := &domain.Member{
		ID:          id,
		FamilyID:    familyID,
		DisplayName: displayName,
		ParentID:    parentID,
		SpouseID:    spouseID,
		Level:       level,
	}

	if err := s.memberRepo.Create(ctx, member); err != nil {
		return nil, err
	}

	return member, nil
}

func (s *FamilyService) ListMembers(ctx context.Context, familyID string) ([]*domain.Member, error) {
	return s.memberRepo.ListByFamily(ctx, familyID)
}

func (s *FamilyService) UpdateMember(ctx context.Context, member *domain.Member) error {
	return s.memberRepo.Update(ctx, member)
}

func (s *FamilyService) DeleteMember(ctx context.Context, memberID string) error {
	return s.memberRepo.Delete(ctx, memberID)
}

func (s *FamilyService) UpdateFamilyOwner(ctx context.Context, familyID, newOwnerID string) error {
	family, err := s.familyRepo.GetByID(ctx, familyID)
	if err != nil {
		return err
	}
	if family == nil {
		return fmt.Errorf("family not found")
	}

	user := middleware.GetUser(ctx)
	if user == nil || family.OwnerID != user.UID {
		return fmt.Errorf("unauthorized")
	}

	family.OwnerID = newOwnerID
	return s.familyRepo.Update(ctx, family)
}

func (s *FamilyService) JoinFamily(ctx context.Context, inviteToken string) (*domain.Family, error) {
	user := middleware.GetUser(ctx)
	if user == nil {
		return nil, fmt.Errorf("unauthenticated")
	}

	// 1. Validate token
	token, err := s.tokenRepo.Get(ctx, inviteToken)
	if err != nil {
		return nil, fmt.Errorf("invalid token")
	}
	if token.IsUsed {
		return nil, fmt.Errorf("token already used")
	}
	if token.ExpiresAt != nil && token.ExpiresAt.Before(time.Now()) {
		return nil, fmt.Errorf("token expired")
	}
	if token.Purpose != authdomain.PurposeFamilyInvite {
		return nil, fmt.Errorf("invalid token purpose")
	}
	if token.AssociatedID == nil {
		return nil, fmt.Errorf("invalid token: no family associated")
	}

	familyID := token.AssociatedID.String()

	// 2. Grant access
	if err := s.familyRepo.AddAccess(ctx, familyID, user.UID, "MEMBER"); err != nil {
		return nil, err
	}

	// 3. Mark token as used (optional, depends on if tokens are multi-use)
	// For now, let's say they are single-use for security unless specified
	if err := s.tokenRepo.MarkAsUsed(ctx, inviteToken); err != nil {
		// Log error but don't fail join? Actually better to fail or handle
		return nil, err
	}

	return s.familyRepo.GetByID(ctx, familyID)
}
