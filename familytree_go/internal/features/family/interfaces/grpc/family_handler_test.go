package grpc

import (
	"context"
	"testing"

	firebaseauth "firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/app"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	familyv1 "github.com/mibi2007/familytree/familytree_go/proto/family/v1"
	"github.com/stretchr/testify/require"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type handlerMemberRepository struct {
	members []*domain.Member
}

func (r *handlerMemberRepository) Create(context.Context, *domain.Member) error { return nil }
func (r *handlerMemberRepository) GetByID(context.Context, string) (*domain.Member, error) {
	return nil, nil
}
func (r *handlerMemberRepository) Update(context.Context, *domain.Member) error { return nil }
func (r *handlerMemberRepository) Delete(context.Context, string) error         { return nil }
func (r *handlerMemberRepository) ListByFamily(context.Context, string) ([]*domain.Member, error) {
	return r.members, nil
}

type handlerFamilyRepository struct {
	accessible bool
}

func (r *handlerFamilyRepository) Create(context.Context, *domain.Family) error { return nil }
func (r *handlerFamilyRepository) GetByID(context.Context, string) (*domain.Family, error) {
	return nil, nil
}
func (r *handlerFamilyRepository) Update(context.Context, *domain.Family) error { return nil }
func (r *handlerFamilyRepository) Delete(context.Context, string) error         { return nil }
func (r *handlerFamilyRepository) ListByOwner(context.Context, string) ([]*domain.Family, error) {
	return nil, nil
}
func (r *handlerFamilyRepository) AddAccess(context.Context, string, string, string) error {
	return nil
}
func (r *handlerFamilyRepository) ListByMember(context.Context, string) ([]*domain.Family, error) {
	if !r.accessible {
		return nil, nil
	}
	return []*domain.Family{{ID: "family-1"}}, nil
}

func authenticatedKinshipContext() context.Context {
	return context.WithValue(
		context.Background(),
		middleware.UserContextKey,
		&firebaseauth.Token{UID: "user-1"},
	)
}

func TestFamilyHandlerGetKinshipReturnsStructuredRelationship(t *testing.T) {
	kinship := app.NewKinshipService(
		&handlerMemberRepository{members: []*domain.Member{
			{ID: "actor", ParentID: "mother"},
			{ID: "mother", ParentID: "grandmother", Gender: "female"},
			{ID: "grandmother", Gender: "female"},
		}},
		&handlerFamilyRepository{accessible: true},
	)
	handler := NewFamilyHandler(nil, kinship)

	result, err := handler.GetKinship(authenticatedKinshipContext(), &familyv1.GetKinshipRequest{
		FamilyId:       "family-1",
		ActingMemberId: "actor",
		TargetMemberId: "grandmother",
	})

	require.NoError(t, err)
	require.Equal(t, "Bà ngoại", result.Title)
	require.Equal(t, "grandparent", result.Relationship)
	require.Equal(t, int32(-2), result.Generation)
	require.Equal(t, "maternal", result.Side)
	require.False(t, result.Ambiguous)
}

func TestFamilyHandlerGetKinshipEnforcesFamilyAccess(t *testing.T) {
	kinship := app.NewKinshipService(
		&handlerMemberRepository{},
		&handlerFamilyRepository{accessible: false},
	)
	handler := NewFamilyHandler(nil, kinship)

	_, err := handler.GetKinship(authenticatedKinshipContext(), &familyv1.GetKinshipRequest{
		FamilyId:       "family-1",
		ActingMemberId: "actor",
		TargetMemberId: "target",
	})

	require.Equal(t, codes.PermissionDenied, status.Code(err))
}

func TestFamilyHandlerGetKinshipRequiresAuthentication(t *testing.T) {
	kinship := app.NewKinshipService(&handlerMemberRepository{}, &handlerFamilyRepository{})
	handler := NewFamilyHandler(nil, kinship)

	_, err := handler.GetKinship(context.Background(), &familyv1.GetKinshipRequest{
		FamilyId:       "family-1",
		ActingMemberId: "actor",
		TargetMemberId: "target",
	})

	require.Equal(t, codes.Unauthenticated, status.Code(err))
}
