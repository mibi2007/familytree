package application_test

import (
	"context"
	"errors"
	"testing"
	"time"

	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/application"
	"github.com/mibi2007/familytree/familytree_go/internal/features/auth/domain"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

// --- Mocks ---

type MockTokenRepository struct {
	mock.Mock
}

func (m *MockTokenRepository) Create(ctx context.Context, token *domain.SecureToken) error {
	args := m.Called(ctx, token)
	return args.Error(0)
}

func (m *MockTokenRepository) Get(ctx context.Context, tokenStr string) (*domain.SecureToken, error) {
	args := m.Called(ctx, tokenStr)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.SecureToken), args.Error(1)
}

func (m *MockTokenRepository) MarkAsUsed(ctx context.Context, tokenStr string) error {
	args := m.Called(ctx, tokenStr)
	return args.Error(0)
}

func (m *MockTokenRepository) DeleteExpired(ctx context.Context) (int64, error) {
	args := m.Called(ctx)
	return args.Get(0).(int64), args.Error(1)
}

type MockUserRepository struct {
	mock.Mock
}

func (m *MockUserRepository) UpsertUser(ctx context.Context, user *domain.User) error {
	args := m.Called(ctx, user)
	return args.Error(0)
}

func (m *MockUserRepository) GetUserByID(ctx context.Context, id string) (*domain.User, error) {
	args := m.Called(ctx, id)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.User), args.Error(1)
}

func (m *MockUserRepository) MarkDeletionRequested(ctx context.Context, id string, requestedAt time.Time) error {
	args := m.Called(ctx, id, requestedAt)
	return args.Error(0)
}

func (m *MockUserRepository) SetUserRole(ctx context.Context, id string, role domain.SystemRole) error {
	args := m.Called(ctx, id, role)
	return args.Error(0)
}

type MockSuperAdminRequestRepository struct {
	mock.Mock
}

func (m *MockSuperAdminRequestRepository) Create(ctx context.Context, req *domain.SuperAdminRequest) error {
	args := m.Called(ctx, req)
	return args.Error(0)
}

func (m *MockSuperAdminRequestRepository) GetByID(ctx context.Context, id string) (*domain.SuperAdminRequest, error) {
	args := m.Called(ctx, id)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.SuperAdminRequest), args.Error(1)
}

func (m *MockSuperAdminRequestRepository) List(ctx context.Context, status domain.RequestStatus, limit int, offset int) ([]*domain.SuperAdminRequest, error) {
	args := m.Called(ctx, status, limit, offset)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).([]*domain.SuperAdminRequest), args.Error(1)
}

func (m *MockSuperAdminRequestRepository) UpdateStatus(ctx context.Context, id string, status domain.RequestStatus, reviewedBy string) error {
	args := m.Called(ctx, id, status, reviewedBy)
	return args.Error(0)
}

func (m *MockSuperAdminRequestRepository) GetLatestByUserID(ctx context.Context, userID string) (*domain.SuperAdminRequest, error) {
	args := m.Called(ctx, userID)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).(*domain.SuperAdminRequest), args.Error(1)
}

// --- Tests ---

func TestRegisterUser(t *testing.T) {
	mockUserRepo := new(MockUserRepository)
	mockTokenRepo := new(MockTokenRepository)
	mockAdminRepo := new(MockSuperAdminRequestRepository)
	authService := application.NewAuthService(mockTokenRepo, mockUserRepo, mockAdminRepo)

	ctx := context.Background()

	t.Run("Success", func(t *testing.T) {
		uid := "test-uid"
		email := "test@example.com"
		displayName := "Test User"
		photoURL := "http://example.com/photo.jpg"
		emailVerified := true

		mockUserRepo.On("UpsertUser", ctx, mock.MatchedBy(func(u *domain.User) bool {
			return u.ID == uid && u.Email == email && u.EmailVerified == emailVerified
		})).Return(nil).Once()

		user, err := authService.RegisterUser(ctx, uid, email, displayName, photoURL, emailVerified)

		assert.NoError(t, err)
		assert.NotNil(t, user)
		assert.Equal(t, uid, user.ID)
		assert.Equal(t, email, user.Email)
		mockUserRepo.AssertExpectations(t)
	})

	t.Run("RepoFailure", func(t *testing.T) {
		mockUserRepo.On("UpsertUser", ctx, mock.Anything).Return(errors.New("db error")).Once()

		user, err := authService.RegisterUser(ctx, "uid", "email", "name", "url", true)

		assert.Error(t, err)
		assert.Nil(t, user)
		mockUserRepo.AssertExpectations(t)
	})
}

func TestRequestAdminAccess(t *testing.T) {
	mockUserRepo := new(MockUserRepository)
	mockTokenRepo := new(MockTokenRepository)
	mockAdminRepo := new(MockSuperAdminRequestRepository)
	authService := application.NewAuthService(mockTokenRepo, mockUserRepo, mockAdminRepo)

	ctx := context.Background()
	tokenStr := "valid-token"
	userID := "user-1"
	reason := "I want to help"

	t.Run("Success", func(t *testing.T) {
		validToken := &domain.SecureToken{
			Token:   tokenStr,
			Purpose: domain.PurposeSuperAdminOnboarding,
			IsUsed:  false,
		}

		mockTokenRepo.On("Get", ctx, tokenStr).Return(validToken, nil).Once()
		mockTokenRepo.On("MarkAsUsed", ctx, tokenStr).Return(nil).Once()
		mockAdminRepo.On("Create", ctx, mock.MatchedBy(func(req *domain.SuperAdminRequest) bool {
			return req.UserID == userID && req.RequestedRole == domain.SystemRoleSuperAdmin
		})).Return(nil).Once()

		req, err := authService.RequestAdminAccess(ctx, userID, tokenStr, string(domain.SystemRoleSuperAdmin), reason)

		assert.NoError(t, err)
		assert.NotNil(t, req)
		assert.Equal(t, domain.SystemRoleSuperAdmin, req.RequestedRole)
		mockTokenRepo.AssertExpectations(t)
		mockAdminRepo.AssertExpectations(t)
	})

	t.Run("InvalidToken", func(t *testing.T) {
		mockTokenRepo.On("Get", ctx, "invalid").Return(nil, errors.New("not found")).Once()

		req, err := authService.RequestAdminAccess(ctx, userID, "invalid", string(domain.SystemRoleSuperAdmin), reason)

		assert.Error(t, err)
		assert.Nil(t, req)
		mockTokenRepo.AssertExpectations(t)
	})

	t.Run("WrongPurpose", func(t *testing.T) {
		wrongToken := &domain.SecureToken{
			Token:   tokenStr,
			Purpose: domain.PurposeFamilyInvite, // Wrong purpose
			IsUsed:  false,
		}

		mockTokenRepo.On("Get", ctx, tokenStr).Return(wrongToken, nil).Once()

		req, err := authService.RequestAdminAccess(ctx, userID, tokenStr, string(domain.SystemRoleSuperAdmin), reason)

		assert.Error(t, err)
		assert.Contains(t, err.Error(), "token is not for system admin onboarding")
		assert.Nil(t, req)
		mockTokenRepo.AssertExpectations(t)
	})
}

func TestGenerateInviteToken(t *testing.T) {
	mockUserRepo := new(MockUserRepository)
	mockTokenRepo := new(MockTokenRepository)
	mockAdminRepo := new(MockSuperAdminRequestRepository)
	authService := application.NewAuthService(mockTokenRepo, mockUserRepo, mockAdminRepo)

	ctx := context.Background()

	t.Run("Success", func(t *testing.T) {
		mockTokenRepo.On("Create", ctx, mock.MatchedBy(func(tok *domain.SecureToken) bool {
			return tok.Purpose == domain.PurposeSuperAdminOnboarding && len(tok.Token) > 0
		})).Return(nil).Once()

		token, err := authService.GenerateInviteToken(ctx, 3600, "", string(domain.PurposeSuperAdminOnboarding), "admin-1")

		assert.NoError(t, err)
		assert.NotNil(t, token)
		assert.Equal(t, domain.PurposeSuperAdminOnboarding, token.Purpose)
		mockTokenRepo.AssertExpectations(t)
	})
}

func TestGetLatestAdminRequest(t *testing.T) {
	mockUserRepo := new(MockUserRepository)
	mockTokenRepo := new(MockTokenRepository)
	mockAdminRepo := new(MockSuperAdminRequestRepository)
	authService := application.NewAuthService(mockTokenRepo, mockUserRepo, mockAdminRepo)

	ctx := context.Background()
	userID := "user-123"

	t.Run("Found", func(t *testing.T) {
		expectedReq := &domain.SuperAdminRequest{
			ID:     "req-1",
			UserID: userID,
			Status: domain.RequestStatusPending,
		}
		mockAdminRepo.On("GetLatestByUserID", ctx, userID).Return(expectedReq, nil).Once()

		req, err := authService.GetLatestAdminRequest(ctx, userID)

		assert.NoError(t, err)
		assert.Equal(t, expectedReq, req)
		mockAdminRepo.AssertExpectations(t)
	})

	t.Run("NotFound", func(t *testing.T) {
		mockAdminRepo.On("GetLatestByUserID", ctx, "unknown").Return(nil, nil).Once()

		req, err := authService.GetLatestAdminRequest(ctx, "unknown")

		assert.NoError(t, err)
		assert.Nil(t, req)
		mockAdminRepo.AssertExpectations(t)
	})

	t.Run("Error", func(t *testing.T) {
		mockAdminRepo.On("GetLatestByUserID", ctx, "error-user").Return(nil, errors.New("db error")).Once()

		req, err := authService.GetLatestAdminRequest(ctx, "error-user")

		assert.Error(t, err)
		assert.Nil(t, req)
		mockAdminRepo.AssertExpectations(t)
	})
}
func TestReviewAdminRequest(t *testing.T) {
	mockUserRepo := new(MockUserRepository)
	mockTokenRepo := new(MockTokenRepository)
	mockAdminRepo := new(MockSuperAdminRequestRepository)
	authService := application.NewAuthService(mockTokenRepo, mockUserRepo, mockAdminRepo)

	ctx := context.Background()
	reqID := "req-1"
	reviewerID := "admin-1"
	userID := "user-123"

	t.Run("ApproveSuccess", func(t *testing.T) {
		req := &domain.SuperAdminRequest{
			ID:            reqID,
			UserID:        userID,
			RequestedRole: domain.SystemRoleSuperAdmin,
		}

		mockAdminRepo.On("GetByID", ctx, reqID).Return(req, nil).Once()
		mockAdminRepo.On("UpdateStatus", ctx, reqID, domain.RequestStatusApproved, reviewerID).Return(nil).Once()
		mockUserRepo.On("SetUserRole", ctx, userID, domain.SystemRoleSuperAdmin).Return(nil).Once()

		err := authService.ReviewAdminRequest(ctx, reqID, domain.RequestStatusApproved, reviewerID)

		assert.NoError(t, err)
		mockAdminRepo.AssertExpectations(t)
		mockUserRepo.AssertExpectations(t)
	})

	t.Run("RejectSuccess", func(t *testing.T) {
		req := &domain.SuperAdminRequest{
			ID:     reqID,
			UserID: userID,
		}

		mockAdminRepo.On("GetByID", ctx, reqID).Return(req, nil).Once()
		mockAdminRepo.On("UpdateStatus", ctx, reqID, domain.RequestStatusRejected, reviewerID).Return(nil).Once()
		// SetUserRole should NOT be called

		err := authService.ReviewAdminRequest(ctx, reqID, domain.RequestStatusRejected, reviewerID)

		assert.NoError(t, err)
		mockAdminRepo.AssertExpectations(t)
		mockUserRepo.AssertExpectations(t)
	})

	t.Run("NotFound", func(t *testing.T) {
		mockAdminRepo.On("GetByID", ctx, "unknown").Return(nil, nil).Once()

		err := authService.ReviewAdminRequest(ctx, "unknown", domain.RequestStatusApproved, reviewerID)

		assert.Error(t, err)
		assert.Contains(t, err.Error(), "request not found")
		mockAdminRepo.AssertExpectations(t)
	})
}
