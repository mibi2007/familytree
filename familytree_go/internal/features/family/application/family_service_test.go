package application_test

import (
	"context"
	"testing"
	"time"

	"firebase.google.com/go/v4/auth"
	"github.com/google/uuid"
	authdomain "github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/application"
	"github.com/mibi2007/familytree/familytree_go/internal/features/family/domain"
	"github.com/mibi2007/familytree/familytree_go/internal/middleware"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

// --- Mocks ---

type MockFamilyRepository struct {
	mock.Mock
}

func (m *MockFamilyRepository) Create(ctx context.Context, f *domain.Family) error {
	args := m.Called(ctx, f)
	if f != nil {
		f.ID = "new-family-id"
		f.CreatedAt = time.Now()
		f.UpdatedAt = time.Now()
	}
	return args.Error(0)
}

func (m *MockFamilyRepository) GetByID(ctx context.Context, id string) (*domain.Family, error) {
	args := m.Called(ctx, id)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.Family), args.Error(1)
}

func (m *MockFamilyRepository) Update(ctx context.Context, f *domain.Family) error {
	args := m.Called(ctx, f)
	return args.Error(0)
}

func (m *MockFamilyRepository) Delete(ctx context.Context, id string) error {
	args := m.Called(ctx, id)
	return args.Error(0)
}

func (m *MockFamilyRepository) ListByOwner(ctx context.Context, ownerID string) ([]*domain.Family, error) {
	args := m.Called(ctx, ownerID)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).([]*domain.Family), args.Error(1)
}

func (m *MockFamilyRepository) AddAccess(ctx context.Context, familyID string, userID string, role string) error {
	args := m.Called(ctx, familyID, userID, role)
	return args.Error(0)
}

func (m *MockFamilyRepository) ListByMember(ctx context.Context, userID string) ([]*domain.Family, error) {
	args := m.Called(ctx, userID)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).([]*domain.Family), args.Error(1)
}

type MockMemberRepository struct {
	mock.Mock
}

func (m *MockMemberRepository) Create(ctx context.Context, member *domain.Member) error {
	args := m.Called(ctx, member)
	if member != nil {
		member.CreatedAt = time.Now()
		member.UpdatedAt = time.Now()
	}
	return args.Error(0)
}

func (m *MockMemberRepository) GetByID(ctx context.Context, id string) (*domain.Member, error) {
	args := m.Called(ctx, id)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.Member), args.Error(1)
}

func (m *MockMemberRepository) Update(ctx context.Context, member *domain.Member) error {
	args := m.Called(ctx, member)
	return args.Error(0)
}

func (m *MockMemberRepository) Delete(ctx context.Context, id string) error {
	args := m.Called(ctx, id)
	return args.Error(0)
}

func (m *MockMemberRepository) ListByFamily(ctx context.Context, familyID string) ([]*domain.Member, error) {
	args := m.Called(ctx, familyID)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).([]*domain.Member), args.Error(1)
}

type MockTokenRepository struct {
	mock.Mock
}

func (m *MockTokenRepository) Create(ctx context.Context, token *authdomain.SecureToken) error {
	args := m.Called(ctx, token)
	return args.Error(0)
}

func (m *MockTokenRepository) Get(ctx context.Context, tokenStr string) (*authdomain.SecureToken, error) {
	args := m.Called(ctx, tokenStr)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*authdomain.SecureToken), args.Error(1)
}

func (m *MockTokenRepository) MarkAsUsed(ctx context.Context, tokenStr string) error {
	args := m.Called(ctx, tokenStr)
	return args.Error(0)
}

func (m *MockTokenRepository) DeleteExpired(ctx context.Context) (int64, error) {
	args := m.Called(ctx)
	return int64(args.Int(0)), args.Error(1)
}

// --- Tests ---

func TestCreateFamily(t *testing.T) {
	mockFamilyRepo := new(MockFamilyRepository)
	mockMemberRepo := new(MockMemberRepository)
	mockTokenRepo := new(MockTokenRepository)
	svc := application.NewFamilyService(mockFamilyRepo, mockMemberRepo, mockTokenRepo)

	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &auth.Token{UID: "user-123"})

	mockFamilyRepo.On("Create", ctx, mock.MatchedBy(func(f *domain.Family) bool {
		return f.Name == "My Family" && f.OwnerID == "user-123"
	})).Return(nil)

	family, err := svc.CreateFamily(ctx, "My Family")

	assert.NoError(t, err)
	assert.NotNil(t, family)
	assert.Equal(t, "My Family", family.Name)
	assert.Equal(t, "user-123", family.OwnerID)
	assert.Equal(t, "new-family-id", family.ID)
	mockFamilyRepo.AssertExpectations(t)
}

func TestAddMember(t *testing.T) {
	mockFamilyRepo := new(MockFamilyRepository)
	mockMemberRepo := new(MockMemberRepository)
	mockTokenRepo := new(MockTokenRepository)
	svc := application.NewFamilyService(mockFamilyRepo, mockMemberRepo, mockTokenRepo)

	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &auth.Token{UID: "user-123"})
	familyID := "family-123"

	// 1. Mock GetFamily found and authorized
	mockFamilyRepo.On("GetByID", ctx, familyID).Return(&domain.Family{ID: familyID, OwnerID: "user-123"}, nil)

	// 2. Mock AddMember (no parent = level 0)
	mockMemberRepo.On("Create", ctx, mock.MatchedBy(func(m *domain.Member) bool {
		return m.DisplayName == "Member 1" && m.FamilyID == familyID && m.Level == 0
	})).Return(nil)

	member, err := svc.AddMember(ctx, familyID, "Member 1", "", "")

	assert.NoError(t, err)
	assert.NotNil(t, member)
	assert.Equal(t, "Member 1", member.DisplayName)
	assert.Equal(t, 0, member.Level)
	mockFamilyRepo.AssertExpectations(t)
	mockMemberRepo.AssertExpectations(t)
}

func TestAddMemberWithParent(t *testing.T) {
	mockFamilyRepo := new(MockFamilyRepository)
	mockMemberRepo := new(MockMemberRepository)
	mockTokenRepo := new(MockTokenRepository)
	svc := application.NewFamilyService(mockFamilyRepo, mockMemberRepo, mockTokenRepo)

	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &auth.Token{UID: "user-123"})
	familyID := "family-123"
	parentID := "parent-456"

	mockFamilyRepo.On("GetByID", ctx, familyID).Return(&domain.Family{ID: familyID, OwnerID: "user-123"}, nil)

	// Mock Parent lookup
	mockMemberRepo.On("GetByID", ctx, parentID).Return(&domain.Member{ID: parentID, Level: 1}, nil)

	// Mock AddMember (parent level 1 => child level 2)
	mockMemberRepo.On("Create", ctx, mock.MatchedBy(func(m *domain.Member) bool {
		return m.DisplayName == "Child" && m.Level == 2 && m.ParentID == parentID
	})).Return(nil)

	member, err := svc.AddMember(ctx, familyID, "Child", parentID, "")

	assert.NoError(t, err)
	assert.Equal(t, 2, member.Level)
	mockMemberRepo.AssertExpectations(t)
}

func TestJoinFamily(t *testing.T) {
	mockFamilyRepo := new(MockFamilyRepository)
	mockMemberRepo := new(MockMemberRepository)
	mockTokenRepo := new(MockTokenRepository)
	svc := application.NewFamilyService(mockFamilyRepo, mockMemberRepo, mockTokenRepo)

	ctx := context.WithValue(context.Background(), middleware.UserContextKey, &auth.Token{UID: "user-123"})
	inviteToken := "valid-token"
	familyID := "550e8400-e29b-41d4-a716-446655440000"
	familyIDUUID, _ := uuid.Parse(familyID)

	token := &authdomain.SecureToken{
		Token:        inviteToken,
		Purpose:      authdomain.PurposeFamilyInvite,
		AssociatedID: &familyIDUUID,
		IsUsed:       false,
	}

	mockTokenRepo.On("Get", ctx, inviteToken).Return(token, nil)
	mockFamilyRepo.On("AddAccess", ctx, familyID, "user-123", "MEMBER").Return(nil)
	mockTokenRepo.On("MarkAsUsed", ctx, inviteToken).Return(nil)
	mockFamilyRepo.On("GetByID", ctx, familyID).Return(&domain.Family{ID: familyID, Name: "Joined Family"}, nil)

	family, err := svc.JoinFamily(ctx, inviteToken)

	assert.NoError(t, err)
	assert.NotNil(t, family)
	assert.Equal(t, "Joined Family", family.Name)
	mockTokenRepo.AssertExpectations(t)
	mockFamilyRepo.AssertExpectations(t)
}
