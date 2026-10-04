package app

import (
	"context"
	"testing"

	firebaseauth "firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/stretchr/testify/require"
)

type kinshipMemberRepository struct {
	members []*domain.Member
	err     error
}

func (r *kinshipMemberRepository) Create(context.Context, *domain.Member) error { return nil }
func (r *kinshipMemberRepository) GetByID(context.Context, string) (*domain.Member, error) {
	return nil, nil
}
func (r *kinshipMemberRepository) Update(context.Context, *domain.Member) error { return nil }
func (r *kinshipMemberRepository) Delete(context.Context, string) error         { return nil }
func (r *kinshipMemberRepository) ListByFamily(context.Context, string) ([]*domain.Member, error) {
	return r.members, r.err
}

type kinshipFamilyRepository struct {
	families []*domain.Family
}

func (r *kinshipFamilyRepository) Create(context.Context, *domain.Family) error { return nil }
func (r *kinshipFamilyRepository) GetByID(context.Context, string) (*domain.Family, error) {
	return nil, nil
}
func (r *kinshipFamilyRepository) Update(context.Context, *domain.Family) error { return nil }
func (r *kinshipFamilyRepository) Delete(context.Context, string) error         { return nil }
func (r *kinshipFamilyRepository) ListByOwner(context.Context, string) ([]*domain.Family, error) {
	return r.families, nil
}
func (r *kinshipFamilyRepository) AddAccess(context.Context, string, string, string) error {
	return nil
}
func (r *kinshipFamilyRepository) ListByMember(context.Context, string) ([]*domain.Family, error) {
	return r.families, nil
}

func kinshipContext() context.Context {
	return context.WithValue(
		context.Background(),
		middleware.UserContextKey,
		&firebaseauth.Token{UID: "user-1"},
	)
}

func accessibleFamilies() *kinshipFamilyRepository {
	return &kinshipFamilyRepository{families: []*domain.Family{{ID: "family-1"}}}
}

func TestKinshipServiceCalculate(t *testing.T) {
	service := NewKinshipService(&kinshipMemberRepository{members: []*domain.Member{
		{ID: "actor", ParentID: "mother"},
		{ID: "mother", ParentID: "grandmother", Gender: "female"},
		{ID: "grandmother", Gender: "female"},
	}}, accessibleFamilies())

	result, err := service.Calculate(kinshipContext(), "family-1", "actor", "grandmother")

	require.NoError(t, err)
	require.Equal(t, "Bà ngoại", result.Title)
}

func TestKinshipServiceBuildTitleMappingOmitsAmbiguousAndDuplicateTitles(t *testing.T) {
	service := NewKinshipService(&kinshipMemberRepository{members: []*domain.Member{
		{ID: "actor", ParentID: "father"},
		{ID: "father", ParentID: "root", Gender: "male", BirthDate: "1970-01-01"},
		{ID: "older-uncle-1", ParentID: "root", Gender: "male", BirthDate: "1960-01-01"},
		{ID: "older-uncle-2", ParentID: "root", Gender: "male", BirthDate: "1965-01-01"},
		{ID: "younger-aunt", ParentID: "root", Gender: "female", BirthDate: "1975-01-01"},
		{ID: "unknown-age-uncle", ParentID: "root", Gender: "male"},
	}}, accessibleFamilies())

	mapping, err := service.BuildTitleMapping(kinshipContext(), "family-1", "actor")

	require.NoError(t, err)
	require.Equal(t, "father", mapping["Bố"])
	require.Equal(t, "younger-aunt", mapping["Cô"])
	require.NotContains(t, mapping, "Bác")
	require.NotContains(t, mapping, "Chú")
}

func TestKinshipServiceBuildTitleMappingRequiresActingMemberInFamily(t *testing.T) {
	service := NewKinshipService(
		&kinshipMemberRepository{members: []*domain.Member{{ID: "member"}}},
		accessibleFamilies(),
	)

	_, err := service.BuildTitleMapping(kinshipContext(), "family-1", "missing")

	require.ErrorIs(t, err, domain.ErrKinshipMemberNotFound)
}

func TestKinshipServiceDeniesInaccessibleFamily(t *testing.T) {
	service := NewKinshipService(&kinshipMemberRepository{}, &kinshipFamilyRepository{})

	_, err := service.Calculate(kinshipContext(), "family-1", "actor", "target")

	require.ErrorIs(t, err, domain.ErrKinshipAccessDenied)
}
