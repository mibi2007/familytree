package app

import (
	"context"
	"errors"
	"fmt"

	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
)

type KinshipService struct {
	members  domain.MemberRepository
	families domain.FamilyRepository
}

func NewKinshipService(members domain.MemberRepository, families domain.FamilyRepository) *KinshipService {
	return &KinshipService{members: members, families: families}
}

func (s *KinshipService) Calculate(ctx context.Context, familyID, actingMemberID, targetMemberID string) (domain.KinshipRelationship, error) {
	if err := s.authorize(ctx, familyID); err != nil {
		return domain.KinshipRelationship{}, err
	}
	calculator, _, err := s.calculator(ctx, familyID)
	if err != nil {
		return domain.KinshipRelationship{}, err
	}
	return calculator.Calculate(actingMemberID, targetMemberID)
}

// BuildTitleMapping returns only unambiguous, unique titles. A duplicated title
// cannot safely identify one member in an AI prompt, so all collisions are omitted.
func (s *KinshipService) BuildTitleMapping(ctx context.Context, familyID, actingMemberID string) (map[string]string, error) {
	if err := s.authorize(ctx, familyID); err != nil {
		return nil, err
	}
	calculator, members, err := s.calculator(ctx, familyID)
	if err != nil {
		return nil, err
	}
	if _, err := calculator.Calculate(actingMemberID, actingMemberID); err != nil {
		return nil, err
	}

	mapping := make(map[string]string)
	duplicates := make(map[string]struct{})
	for _, member := range members {
		result, err := calculator.Calculate(actingMemberID, member.ID)
		if errors.Is(err, domain.ErrKinshipNotResolved) {
			continue
		}
		if err != nil {
			return nil, err
		}
		if result.Ambiguous {
			continue
		}
		if _, duplicate := duplicates[result.Title]; duplicate {
			continue
		}
		if _, exists := mapping[result.Title]; exists {
			delete(mapping, result.Title)
			duplicates[result.Title] = struct{}{}
			continue
		}
		mapping[result.Title] = member.ID
	}
	return mapping, nil
}

func (s *KinshipService) authorize(ctx context.Context, familyID string) error {
	user := middleware.GetUser(ctx)
	if user == nil {
		return domain.ErrKinshipUnauthenticated
	}
	if s == nil || s.families == nil {
		return fmt.Errorf("kinship family repository is not configured")
	}
	families, err := s.families.ListByMember(ctx, user.UID)
	if err != nil {
		return fmt.Errorf("list accessible families for kinship: %w", err)
	}
	for _, family := range families {
		if family != nil && family.ID == familyID {
			return nil
		}
	}
	return domain.ErrKinshipAccessDenied
}

func (s *KinshipService) calculator(ctx context.Context, familyID string) (*domain.KinshipCalculator, []*domain.Member, error) {
	if s == nil || s.members == nil {
		return nil, nil, fmt.Errorf("kinship member repository is not configured")
	}
	members, err := s.members.ListByFamily(ctx, familyID)
	if err != nil {
		return nil, nil, fmt.Errorf("list family members for kinship: %w", err)
	}
	calculator, err := domain.NewKinshipCalculator(members)
	if err != nil {
		return nil, nil, err
	}
	return calculator, members, nil
}
