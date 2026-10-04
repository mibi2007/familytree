package domain

import (
	"errors"
	"fmt"
	"strings"
	"time"
)

var (
	ErrKinshipMemberNotFound  = errors.New("kinship member not found")
	ErrKinshipNotResolved     = errors.New("kinship relationship not resolved")
	ErrKinshipUnauthenticated = errors.New("kinship authentication required")
	ErrKinshipAccessDenied    = errors.New("kinship family access denied")
)

type KinshipSide string

const (
	KinshipSideUnknown  KinshipSide = "unknown"
	KinshipSidePaternal KinshipSide = "paternal"
	KinshipSideMaternal KinshipSide = "maternal"
	KinshipSideSpouse   KinshipSide = "spouse"
)

type KinshipGender string

const (
	KinshipGenderUnknown KinshipGender = "unknown"
	KinshipGenderMale    KinshipGender = "male"
	KinshipGenderFemale  KinshipGender = "female"
)

type KinshipAgeOrder string

const (
	KinshipAgeUnknown KinshipAgeOrder = "unknown"
	KinshipAgeOlder   KinshipAgeOrder = "older"
	KinshipAgeYounger KinshipAgeOrder = "younger"
)

type KinshipKind string

const (
	KinshipSelf          KinshipKind = "self"
	KinshipParent        KinshipKind = "parent"
	KinshipChild         KinshipKind = "child"
	KinshipSpouse        KinshipKind = "spouse"
	KinshipSibling       KinshipKind = "sibling"
	KinshipGrandparent   KinshipKind = "grandparent"
	KinshipParentSibling KinshipKind = "parent_sibling"
)

// KinshipRelationship describes how the acting member addresses the target.
// Generation is relative to the actor: ancestors are negative, descendants positive.
type KinshipRelationship struct {
	ActorID    string
	TargetID   string
	Title      string
	Kind       KinshipKind
	Generation int
	Side       KinshipSide
	Gender     KinshipGender
	AgeOrder   KinshipAgeOrder
	ViaSpouse  bool
	Ambiguous  bool
}

type KinshipCalculator struct {
	members map[string]*Member
}

func NewKinshipCalculator(members []*Member) (*KinshipCalculator, error) {
	indexed := make(map[string]*Member, len(members))
	for _, member := range members {
		if member == nil || strings.TrimSpace(member.ID) == "" {
			return nil, fmt.Errorf("invalid kinship member")
		}
		if _, exists := indexed[member.ID]; exists {
			return nil, fmt.Errorf("duplicate kinship member %q", member.ID)
		}
		indexed[member.ID] = member
	}
	return &KinshipCalculator{members: indexed}, nil
}

func (c *KinshipCalculator) Calculate(actorID, targetID string) (KinshipRelationship, error) {
	actor, ok := c.members[actorID]
	if !ok {
		return KinshipRelationship{}, fmt.Errorf("%w: %s", ErrKinshipMemberNotFound, actorID)
	}
	target, ok := c.members[targetID]
	if !ok {
		return KinshipRelationship{}, fmt.Errorf("%w: %s", ErrKinshipMemberNotFound, targetID)
	}

	if relationship, resolved := c.calculateBlood(actor, target); resolved {
		return relationship, nil
	}

	spouse := c.spouseOf(actor)
	if spouse != nil {
		if spouse.ID == target.ID {
			return relationship(actor, target, spouseTitle(target), KinshipSpouse, 0, KinshipSideSpouse), nil
		}
		if related, resolved := c.calculateBlood(spouse, target); resolved {
			related.ActorID = actor.ID
			related.ViaSpouse = true
			return related, nil
		}
	}

	return KinshipRelationship{}, fmt.Errorf("%w: %s to %s", ErrKinshipNotResolved, actorID, targetID)
}

func (c *KinshipCalculator) calculateBlood(actor, target *Member) (KinshipRelationship, bool) {
	if actor.ID == target.ID {
		return relationship(actor, target, "Bản thân", KinshipSelf, 0, KinshipSideUnknown), true
	}
	if actor.ParentID == target.ID {
		title, ambiguous := parentTitle(target)
		result := relationship(actor, target, title, KinshipParent, -1, sideFromParent(target))
		result.Ambiguous = ambiguous
		return result, true
	}
	if target.ParentID == actor.ID {
		return relationship(actor, target, "Con", KinshipChild, 1, KinshipSideUnknown), true
	}
	if c.areSpouses(actor, target) {
		return relationship(actor, target, spouseTitle(target), KinshipSpouse, 0, KinshipSideSpouse), true
	}

	parent := c.members[actor.ParentID]
	if parent != nil {
		if parent.ParentID == target.ID {
			title, ambiguous := grandparentTitle(target, sideFromParent(parent))
			result := relationship(actor, target, title, KinshipGrandparent, -2, sideFromParent(parent))
			result.Ambiguous = ambiguous
			return result, true
		}
		if target.ParentID != "" && target.ParentID == parent.ParentID {
			title, order, ambiguous := parentSiblingTitle(parent, target)
			result := relationship(actor, target, title, KinshipParentSibling, -1, sideFromParent(parent))
			result.AgeOrder = order
			result.Ambiguous = ambiguous
			return result, true
		}
	}

	if actor.ParentID != "" && actor.ParentID == target.ParentID {
		title, order, ambiguous := siblingTitle(actor, target)
		result := relationship(actor, target, title, KinshipSibling, 0, KinshipSideUnknown)
		result.AgeOrder = order
		result.Ambiguous = ambiguous
		return result, true
	}

	return KinshipRelationship{}, false
}

func (c *KinshipCalculator) spouseOf(member *Member) *Member {
	if member.SpouseID != "" {
		if spouse := c.members[member.SpouseID]; spouse != nil {
			return spouse
		}
	}
	for _, candidate := range c.members {
		if candidate.SpouseID == member.ID {
			return candidate
		}
	}
	return nil
}

func (c *KinshipCalculator) areSpouses(first, second *Member) bool {
	return first.SpouseID == second.ID || second.SpouseID == first.ID
}

func relationship(actor, target *Member, title string, kind KinshipKind, generation int, side KinshipSide) KinshipRelationship {
	return KinshipRelationship{
		ActorID:    actor.ID,
		TargetID:   target.ID,
		Title:      title,
		Kind:       kind,
		Generation: generation,
		Side:       side,
		Gender:     normalizeGender(target.Gender),
		AgeOrder:   KinshipAgeUnknown,
	}
}

func normalizeGender(value string) KinshipGender {
	switch strings.ToLower(strings.TrimSpace(value)) {
	case "male", "m", "nam":
		return KinshipGenderMale
	case "female", "f", "nữ", "nu":
		return KinshipGenderFemale
	default:
		return KinshipGenderUnknown
	}
}

func sideFromParent(parent *Member) KinshipSide {
	switch normalizeGender(parent.Gender) {
	case KinshipGenderMale:
		return KinshipSidePaternal
	case KinshipGenderFemale:
		return KinshipSideMaternal
	default:
		return KinshipSideUnknown
	}
}

func parentTitle(target *Member) (string, bool) {
	switch normalizeGender(target.Gender) {
	case KinshipGenderMale:
		return "Bố", false
	case KinshipGenderFemale:
		return "Mẹ", false
	default:
		return "Cha/Mẹ", true
	}
}

func spouseTitle(target *Member) string {
	switch normalizeGender(target.Gender) {
	case KinshipGenderMale:
		return "Chồng"
	case KinshipGenderFemale:
		return "Vợ"
	default:
		return "Vợ/Chồng"
	}
}

func grandparentTitle(target *Member, side KinshipSide) (string, bool) {
	gender := normalizeGender(target.Gender)
	if gender == KinshipGenderUnknown || side == KinshipSideUnknown {
		return "Ông/Bà", true
	}
	prefix := "Ông"
	if gender == KinshipGenderFemale {
		prefix = "Bà"
	}
	if side == KinshipSidePaternal {
		return prefix + " nội", false
	}
	return prefix + " ngoại", false
}

func parentSiblingTitle(parent, target *Member) (string, KinshipAgeOrder, bool) {
	order := compareAge(target, parent)
	if order == KinshipAgeOlder {
		return "Bác", order, false
	}

	gender := normalizeGender(target.Gender)
	side := sideFromParent(parent)
	ambiguous := order == KinshipAgeUnknown || gender == KinshipGenderUnknown || side == KinshipSideUnknown
	switch {
	case side == KinshipSidePaternal && gender == KinshipGenderMale:
		return "Chú", order, ambiguous
	case side == KinshipSidePaternal && gender == KinshipGenderFemale:
		return "Cô", order, ambiguous
	case side == KinshipSideMaternal && gender == KinshipGenderMale:
		return "Cậu", order, ambiguous
	case side == KinshipSideMaternal && gender == KinshipGenderFemale:
		return "Dì", order, ambiguous
	default:
		return "Bác/Cô/Chú/Cậu/Dì", order, true
	}
}

func siblingTitle(actor, target *Member) (string, KinshipAgeOrder, bool) {
	order := compareAge(target, actor)
	if order == KinshipAgeYounger {
		return "Em", order, false
	}
	gender := normalizeGender(target.Gender)
	if order == KinshipAgeOlder && gender == KinshipGenderMale {
		return "Anh", order, false
	}
	if order == KinshipAgeOlder && gender == KinshipGenderFemale {
		return "Chị", order, false
	}
	return "Anh/Chị/Em", order, true
}

func compareAge(first, second *Member) KinshipAgeOrder {
	firstBirth, firstOK := parseBirthDate(first.BirthDate)
	secondBirth, secondOK := parseBirthDate(second.BirthDate)
	if !firstOK || !secondOK || firstBirth.Equal(secondBirth) {
		return KinshipAgeUnknown
	}
	if firstBirth.Before(secondBirth) {
		return KinshipAgeOlder
	}
	return KinshipAgeYounger
}

func parseBirthDate(value string) (time.Time, bool) {
	for _, layout := range []string{"2006-01-02", time.RFC3339} {
		parsed, err := time.Parse(layout, strings.TrimSpace(value))
		if err == nil {
			return parsed, true
		}
	}
	return time.Time{}, false
}
