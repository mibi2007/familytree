package middleware

import (
	"context"
	"testing"

	"firebase.google.com/go/v4/auth"
	"github.com/mibi2007/familytree/familytree_go/internal/features/system/domain"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"google.golang.org/grpc"
)

// --- Mocks ---

type MockLogRepository struct {
	mock.Mock
}

func (m *MockLogRepository) CreateAuditLog(ctx context.Context, log *domain.AuditLog) error {
	args := m.Called(ctx, log)
	return args.Error(0)
}

// --- Tests ---

func TestAuditInterceptor(t *testing.T) {
	// Setup
	mockRepo := new(MockLogRepository)
	interceptor := AuditInterceptor(mockRepo)
	ctx := context.Background()

	// Mock handler that returns successful response
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return "success", nil
	}

	t.Run("LogsActionWhenUserIsAuthenticated", func(t *testing.T) {
		// Prepare context with user
		userToken := &auth.Token{UID: "admin-123"}
		authCtx := context.WithValue(ctx, UserContextKey, userToken)

		// Define the method being called (must be in the list of verifiable actions)
		info := &grpc.UnaryServerInfo{
			FullMethod: "/auth.v1.AuthService/ReviewAdminRequest",
		}

		// Expect CreateAuditLog to be called
		mockRepo.On("CreateAuditLog", authCtx, mock.MatchedBy(func(log *domain.AuditLog) bool {
			return log.AdminID == "admin-123" && log.Action == info.FullMethod
		})).Return(nil).Once()

		// Execute
		resp, err := interceptor(authCtx, nil, info, handler)

		// Assert
		assert.NoError(t, err)
		assert.Equal(t, "success", resp)
		mockRepo.AssertExpectations(t)
	})

	t.Run("DoesNotLogIfUserNotAuthenticated", func(t *testing.T) {
		// Context without user
		info := &grpc.UnaryServerInfo{
			FullMethod: "/auth.v1.AuthService/ReviewAdminRequest",
		}

		// Execute (repo should NOT be called)
		resp, err := interceptor(ctx, nil, info, handler)

		assert.NoError(t, err)
		assert.Equal(t, "success", resp)
		mockRepo.AssertNotCalled(t, "CreateAuditLog")
	})

	t.Run("DoesNotLogIgnoredMethods", func(t *testing.T) {
		userToken := &auth.Token{UID: "admin-123"}
		authCtx := context.WithValue(ctx, UserContextKey, userToken)

		info := &grpc.UnaryServerInfo{
			FullMethod: "/auth.v1.AuthService/SomeReadMethod", // Not in the allowlist
		}

		resp, err := interceptor(authCtx, nil, info, handler)

		assert.NoError(t, err)
		assert.Equal(t, "success", resp)
		mockRepo.AssertNotCalled(t, "CreateAuditLog")
	})
}
